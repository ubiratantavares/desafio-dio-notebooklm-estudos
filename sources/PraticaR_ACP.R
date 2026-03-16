###############################################################
# Análise de Dados como Método de Apoio às Políticas Públicas #
# Analise Multivariada                                        #
# Análise de Componentes Principais                           #
# Prof. Adriana Andrade - UFRRJ                               #
##############################################################

# Dados de Criminalidade SP -----------------------------------------------

# HD = homicidio doloso
# F = furto
# R = roubo
# RFV = roubo e furto de veiculos
#

data_crimes <-data.frame(
  HD = c(10.85, 14.13, 8.62, 23.04, 16.04, 25.39, 42.55, 43.74, 42.86),
  F = c(1500.8, 1496.07, 1448.79, 1277.33, 1204.02, 1292.91, 797.16, 1190.94, 1590.66), 
  R = c(149.35, 187.99, 130.97, 424.87, 214.36, 358.39, 520.73, 1139.52, 721.9),
  RFV = c(108.38, 116.66, 69.98, 435.75, 207.06, 268.24, 602.63, 909.21, 275.89))
str(data_crimes)    

Regiao = c("SJRP", "RP", "Bauru", "Campinas", "Sorocaba", "SJC", "GSP", "SP", "Santos")

row.names(data_crimes) <- Regiao

#==== Analise descritiva ====#

apply(data_crimes, 2, mean)
apply(data_crimes, 2, sd)
summary(data_crimes)
boxplot(data_crimes)
plot(data_crimes)
cor(data_crimes)

#==== Analise de Covariancia ====#

# Criacao da matriz de covariancias
cov_crimes<- cov(data_crimes)
cov_crimes

# Objeto com a saida da decomposicao espectral da matriz de covariancias
decomposicao<- eigen(cov_crimes)

# Vetor com os autovalores
decomposicao$values                

# Matriz com os autovetores
decomposicao$vectors  

# Variabilidade total das variaveis originais
sum(apply(data_crimes, 2, var))  
sum(decomposicao$values)


# Geracao das componentes principais a partir funcao - PRINCOMP -----------

## Obtencao das componentes principais a partir dos dados padronizados

# Objeto com a saída da ACP
acp_crimes <- princomp(data_crimes, cor = TRUE)
acp_crimes

# Saida com resultados da ACP (DP das CP, prop de var explicada, prop de var explic acum)
summary(acp_crimes)

# Desvio Padrão da ACP (raiz quadrada do autovalor)
acp_crimes$sdev   

# Variância ACP (autovalor)
acp_crimes$sdev^2

# Screeplot
screeplot(acp_crimes,
          type="lines")

# Autovetores - coeficientes
acp_crimes$loadings                          

# Grafico das variáveis em relação aos eixos
acp_crimes$loadings[,1:2]
plot(acp_crimes$loadings[,1:2],
     xlim=c(-0.5,1),
     ylim=c(-0.5,1))
abline(v=0,h=0)
text(acp_crimes$loadings[,1:2],
     labels = row.names(acp_crimes$loadings[,1:2]),
     cex = 1, col = "red", pos = 3)


# Obtencao dos valores das componentes
ycrimes <- acp_crimes$scores
ycrimes

# Correlacoes entre as variaveis e as componentes
cor(data_crimes,ycrimes)                         

# Grafico com escores
plot(ycrimes)
abline(v=0,h=0)
text(ycrimes[,1],ycrimes[,2],
     labels=row.names(data_crimes),
     pos=3)


biplot(
  acp_crimes,
  col=c("black","red"))

# Código mais elaborado que pode ser utilizado no trabalho
# As bibliotecas FactoMineR e factoextra oferecem bons recursos para a aplicação da ACP

library(FactoMineR)
library(factoextra)

# 1 - Obtenção das componentes
acp <- FactoMineR::PCA(data_crimes, scale.unit = TRUE, graph = FALSE)

# 2 - Definição do número de componentes

#Variância Explicada 
acp$eig

# Scree-plot
fviz_screeplot(acp)

# 3 - Análise das Componentes
## Análise da Relação das Variáveis entre si e com o eixo

# Dimensão 1 e 2
fviz_pca_var(acp, 
             axes = c(1, 2),
             repel = TRUE 
)  


# Análise das correlações

acp$var$cor


# Análise do padrão de agrupamento das observações

# Colocar o nome das observações no objeto gerado pela acp
rownames(acp$ind$coord)<-Regiao

# Biplot de variáveis e observações
fviz_pca_biplot(acp,
                label = "all")

# obtenção dos escores para as duas componentes

escores <- as.data.frame(acp$ind$coord[, 1:2])

data_crimes<-cbind(data_crimes,escores)

summary(data_crimes$Dim.1)


# Análise exploratória dos valores da Primeira componente

row.names(data_crimes)[which.min(data_crimes$Dim.1)]

row.names(data_crimes)[which.max(data_crimes$Dim.1)]

row.names(data_crimes)[data_crimes$Dim.1 > median(data_crimes$Dim.1)]


# Ranking

row.names(data_crimes)[order(data_crimes$Dim.1, decreasing = TRUE)]

