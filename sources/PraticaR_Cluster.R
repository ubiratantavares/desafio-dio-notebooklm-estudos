###############################################################
# Análise de Dados como Método de Apoio às Políticas Públicas #
# Analise Multivariada                                        #
# Análise de Cluster                                          #
# Prof. Adriana Andrade - UFRRJ                               #
##############################################################


# Exemplo - Dados de Criminalidade SP -----------------------------------

# HD = homicidio doloso
# F = furto
# R = roubo
# RFV = roubo e furto de veiculos
# Regiao = c("SJRP", "RP", "Bauru", "Campinas", "Sorocaba", "SJC", "GSP", "SP", "Santos")

# Arrumacao do arquivo
data_crimes <-data.frame(
  HD = c(10.85, 14.13, 8.62, 23.04, 16.04, 25.39, 42.55, 43.74, 42.86),
  F = c(1500.8, 1496.07, 1448.79, 1277.33, 1204.02, 1292.91, 797.16, 1190.94, 1590.66), 
  R = c(149.35, 187.99, 130.97, 424.87, 214.36, 358.39, 520.73, 1139.52, 721.9),
  RFV = c(108.38, 116.66, 69.98, 435.75, 207.06, 268.24, 602.63, 909.21, 275.89))
row.names(data_crimes) <- c("SJRP", "RP", "Bauru", "Campinas", "Sorocaba", "SJC", "GSP", "SP", "Santos")
str(data_crimes)    

# Aglomeracao por metodos hierarquicos ------------------------------------

# Avaliacao das Distancias ------------------------------------------------

# 1 # Licacao Simples - Distancia Euclidiana
dist1 <- dist(data_crimes , method = 'euclidean')
hc1 <- hclust(dist1,method="single")
plot(hc1) #dendograma

# 2 # Licacao Simples - Distancia Euclidiana dados padronizados
data_crimes_z <- as.data.frame(scale(data_crimes))
dist2 <- dist(data_crimes_z, upper = FALSE,method="euclidean")
hc1.1 <- hclust(dist2,method="single")
plot(hc1.1) #dendograma

# Avaliacao dos Metodos de Ligacao ----------------------------------------

# 1 # Licacao Simples - Distancia Euclidiana dados padronizados
hc_simples <- hclust(dist2,method="single")
hc_simples$height ## descreve medida de fusao
plot(hc_simples)  ## dendograma

# 2 # Ligacao Completa - Distancia Euclidiana dados padronizados
hc_completa <- hclust(dist2,method="complete") 
hc_completa$height
plot(hc_completa)

# 3 # Ligacao media - Distancia Euclidiana dados padronizados
hc_media <- hclust(dist2,method="average")
hc_media$height 
plot(hc_media)

# 4 # Metodo Ward -Distancia Euclidiana dados padronizados
hc_ward <- hclust(dist2,method="ward.D2")
hc_ward$height 
plot(hc_ward)

# Detalhamento da analise -------------------------------------------------

plot(hc_simples)
rect.hclust(hc_simples, k=3, border="red")
groups1 <- cutree(hc_simples, k=3)
groups1
ind1 <- row.names(data_crimes)
tab_simples <- table(ind1,groups1)

plot(hc_ward)
rect.hclust(hc_ward, k=3, border="red")
groups2 <- cutree(hc_ward, k=3)
groups2
ind2 <- row.names(data_crimes)
tab_ward <- table(ind2,groups2)


# VALIDACAO ---------------------------------------------------------------

### Correlacao Cofenetica

# Obtencao da matriz cofenetica

(coef.hc_simples <- cophenetic(hc_simples))
(coef.hc_completa <- cophenetic(hc_completa))
(coef.hc_media <- cophenetic(hc_media))
(coef.hc_ward <- cophenetic(hc_ward))

# correlacao
cor(dist2,coef.hc_simples)
cor(dist2,coef.hc_completa)
cor(dist2,coef.hc_media)
cor(dist2,coef.hc_ward)


# Exemplo 2 - dataset USArrest --------------------------------------------

data_usarrets <- USArrests
data_usarrets_z <- as.data.frame(scale(data_usarrets)) #Padronizacao

## Calculo das distancias
dist_e <- dist(data_usarrets_z, upper = FALSE,method="euclidean")

## Aplicar método de ligação

# Podemos testar os quatro métodos. 
hc <- hclust(dist_e, method = "single")

## Metodo Escolhido: Ligacao Completa
hc_usarrests_completa <- hclust(dist_e, method = "complete")
plot(hc_usarrests_completa)
rect.hclust(hc_usarrests_completa, k=4, border="red")
grupos <- cutree(hc_usarrests_completa, k=4)
grupos 
table(grupos)

state <- row.names(data_usarrets)
df_grupo <- as.data.frame(state,grupos)
df_grupo$cluster <- row.names(df_grupo)

# Validacao Exemplo 2 -----------------------------------------------------

# Correlacao Cofenetica
# Obtencao da matriz cofenetica
coef.hc_completa_usarrests <- cophenetic(hc_usarrests_completa)
# correlacao
cor(dist_e,coef.hc_completa_usarrests)

# Silhueta
library(cluster)
# Calcular a pontuação de silhueta
# Essa medida utiliza o vetor de grupos criados com o corte do dendograma
silhueta_usarrests <- silhouette(grupos, dist_e)
summary(silhueta_usarrests)

# Visualizar o gráfico de silhuetas
plot(silhueta_usarrests, col=1:4) 


# Refinando a analise -----------------------------------------------------

# Preparacao do dataset original para receber o resultado do agrupamento

data_usarrets$state <- row.names(data_usarrets)
data_cluster <- merge(data_usarrets,df_grupo, by="state")

# Analise descritiva dos grupos
table(data_cluster$state,sort(data_cluster$cluster))
boxplot(data_cluster$Murder~data_cluster$cluster)
m1 <- aov(data_cluster$Murder~data_cluster$cluster)
summary(m1)

kruskal.test(data_cluster$Murder~data_cluster$cluster)


# Agrupamento Não Hierárquico: k-means ------------------------------------
set.seed(123)
km.usarrests <- kmeans(data_usarrets_z,
                       centers=4)
km.usarrests

km.usarrests$totss
km.usarrests$tot.withinss
km.usarrests$betweenss
km.usarrests$withinss


# Inserir agrupamento no dataset
data_usarrets$cluster <- km.usarrests$cluster

plot(data_usarrets$cluster,data_usarrets$Murder,
     pch=20,
     col=data_usarrets$cluster)

boxplot(data_usarrets$Murder~data_usarrets$cluster)


# Grafico scree plot

# Numero maximo de cluster para testar
n_clusters <- 6

# Initialize total within sum of squares error: wss
wss <- numeric(n_clusters)

set.seed(123)

# Look over 1 to n possible clusters
for (i in 1:n_clusters) {
  # Fit the model: km.out
  km.out <- kmeans(data_usarrets_z, centers = i, nstart = 10)
  # Save the within cluster sum of squares
  wss[i] <- km.out$tot.withinss
}
          
# Scree plot
wss_df <- data.frame(clusters = 1:n_clusters, wss = wss)      

plot(wss_df,
     type = "l",
     main = "Scree plot - wss")
