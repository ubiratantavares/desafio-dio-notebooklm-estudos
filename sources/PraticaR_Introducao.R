###############################################################
# Análise de Dados como Método de Apoio às Políticas Públicas #
# Analise Multivariada                                        #
# Introducao                                                  #
# Prof. Adriana Andrade - UFRRJ                               #
##############################################################

####### Pacotes

install.packages("corrplot")
install.packages("MVN")

library(corrplot)
library(MVN)

############### Revisao de Algebra Linear ####

# Criando uma matriz

A<-matrix(c(2,1,1,2), nrow =2)
A
B<-matrix(c(1,4,-2,2), nrow = 2)
B

matrix(0,nrow = 2,ncol = 2) # matriz de zeros

G = matrix(1:1000, 100, 10) # Matriz a partir de sequencia

# Operacao com matrizes
# Adicao e subtracao
A+B
A-B

#Multiplicacao por Escalar
A*2

# Produto Matricial
A %*% B - #atencao ao operador
  
# Transposicao
  
t(A)

A %*% t(A)

# Determinante
det(A)  

# Matriz Inversa
solve(A)

#Extraindo a diagonal
diag(A)

# Traco
sum(diag(A))

# Autovalores e Autovetores
eigen(A)

# Objeto com a saida da decomposicao espectral da matriz de covariancias
decomposicao<- eigen(A)

# Vetor com os autovalores
lambda <- decomposicao$values                
lambda

# Matriz com os autovetores
ei <- decomposicao$vectors
ei

#Matriz original reconstituida
ei%*% diag(lambda) %*% t(ei)


################ Calculo de distancias ####

# Dados de Criminalidade SP (Artes; Barroso, 2023)
# HD = homicidio doloso
# F = furto
# R = roubo
# RFV = roubo e furto de veiculos
# Regiao = c("SJRP", "RP", "Bauru", "Campinas", "Sorocaba", "SJC", "GSP", "SP", "Santos")

# Entrada dos Dados

data_crimes <-data.frame(
  HD = c(10.85, 14.13, 8.62, 23.04, 16.04, 25.39, 42.55, 43.74, 42.86),
  F = c(1500.8, 1496.07, 1448.79, 1277.33, 1204.02, 1292.91, 797.16, 1190.94, 1590.66), 
  R = c(149.35, 187.99, 130.97, 424.87, 214.36, 358.39, 520.73, 1139.52, 721.9),
  RFV = c(108.38, 116.66, 69.98, 435.75, 207.06, 268.24, 602.63, 909.21, 275.89))
str(data_crimes)  

row.names(data_crimes) <- c("SJRP", "RP", "Bauru", "Campinas", "Sorocaba", "SJC", "GSP", "SP", "Santos")


# Calcular a distancia euclidiana
D <- dist(data_crimes, method = "euclidean")
D

# Padronizar dados
z_data_crimes <- scale(data_crimes)
z_data_crimes 

# Calcular a distancia euclidiana
D_z <- dist(z_data_crimes, method = "euclidean")
D_z


# Distancia de Mahalanobis
mu <- colMeans(data_crimes)
sigma <- cov(data_crimes)

mahalanobis(data_crimes, mu, sigma)


################ Analise descritiva ####

# Total por tipo de crime
colSums(data_crimes)

# Total de crime por localidade
rowSums(data_crimes)

#Media das linhas
colMeans(data_crimes)
apply(data_crimes, 2, mean)

#Desvio Padrao das linhas
apply(data_crimes, 2, sd)

summary(data_crimes)

# Graficos univariados
boxplot(data_crimes)
plot(data_crimes)

# Matriz de correlacao
R <- cor(data_crimes)
R

library(corrplot)

corrplot(R,
         method = c("ellipse"),
         type = "lower"
)

############### Verificacao da Normalidade Multivariada####


### Analise Multivariada - Teste de Mardia
mard <- mvn(data = data_crimes, mvn_test = "mardia")
mard$univariate_normality
mard$multivariate_normality


### Analise Multivariada - Teste de Henze-Zirklers
hz <- mvn(data = data_crimes, mvn_test = "hz")
hz$multivariate_normality


### Analise Multivariada - Teste de Royston
royston <- mvn(data = data_crimes, mvn_test = "royston")
royston$multivariate_normality


# Identificacao de outiler multivariado 

outlier <- mvn(data = data_crimes, mvn_test = "hz", 
    multivariate_outlier_method = "quan")

outlier$multivariate_outliers




