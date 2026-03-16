###############################################################
# Análise de Dados como Método de Apoio às Políticas Públicas #
# Analise Multivariada                                        #
# Análise Fatorial                                            #
# Prof. Adriana Andrade - UFRRJ                               #
##############################################################

# Library
library(psych)


# Exemplo 1 - Qualidade das Escolas -------------------------------

#Foi realizada uma pesquisa com 20 escolas com o intuito de avaliar a 
#qualidade dessas organizações com base em algumas características

# LAB – Índice de qualidade dos laboratórios (0–10)
# TEC – Disponibilidade de recursos tecnológicos (0–10)
# ESP – Qualidade dos espaços físicos (0–10)
# FORM – Percentual de docentes com pós-graduação (%)
# EXP – Média de anos de experiência docente
# DED – Índice de dedicação/engajamento docente (0–10)



dados_educacionais <- data.frame(
  Escola = paste0("E", 1:20),
  
  # Fator 1: Infraestrutura
  LAB  = c(8,7,7,6,9,5,6,8,4,8,6,6,7,5,8,5,6,7,5,9),
  TEC  = c(7,6,8,6,8,5,7,7,4,9,6,5,7,5,7,6,5,8,4,8),
  ESP  = c(8,6,7,7,9,4,6,7,3,8,6,6,7,5,8,5,6,7,5,8),
  
  # Fator 2: Perfil docente
  FORM = c(74,72,75,70,68,85,73,75,88,71,80,79,77,86,69,83,78,74,74,67),
  EXP  = c(10,12,13,14,9,17,12,13,18,11,15,14,13,17,10,16,13,12,12,9),
  DED  = c(7,7,8,8,6,9,7,8,10,7,9,8,7,9,6,8,8,7,9,6)
)

#### Adequação do modelo fatorial aos dados ####

## Preparacao dos dados da matriz de correlacao
R<-cor(dados_educacionais[,2:7])
R

cor.plot(R,numbers = T,
         upper = F,
         main="Correlation")

##Bartlett's test 
cortest.bartlett(R, n = 10,diag=TRUE)


##KMO

kmo <- KMO(R)
kmo


#### Definicao do numero de fatores ####
##Autovalores de R

decomp <- eigen(R)
lambda<-decomp$values;lambda

plot(lambda,type="b", 
     main = "Screeplot",
     xlab="Eigenvalue Number",
     ylab = "Eigenvalue Size")

# Variancia explicada pelo modelo

var <- lambda/sum(lambda)*100
var.cum <- cumsum(lambda/sum(lambda))*100 

pve <- rbind(var,var.cum)
colnames(pve)<-seq(1:6)
pve

#### Extracao dos fatores - Metodo ACP #### 

#Estimar matriz de cargas fatorias nao rotacionadas para 2 fatores
eij<-decomp$vectors
eij

m <- 2
L <- eij[,1:m] %*% diag(sqrt(lambda[1:m]))
L

# Estimar as comunalidades - variancia comum de cada variavel
h2i <- rowSums(L^2);h2i


## A variancia especifica de cada variavel
ui <- diag(R) - h2i; ui

## Estimativas do Modelo
modelo <- round(cbind(h2i, ui),3)
rownames(modelo) <- colnames(R)
colnames(modelo) <- c("Comunalidade", "Especificidade")
modelo

# Obtencao da matriz de correlacoes a partir das cargas e das especificidades
R_est <- L%*%t(L)+diag(ui); R_est

# Analise da qualidade do ajuste da EFA
MRES<-R-R_est; MRES

# Grafico das cargas fatoriais

plot(L,pch = 20, col = "red", 
     xlab = "Cargas do fator 1", 
     ylab = "Cargas do fator 2",
     xlim=c(-1,1),ylim=c(-1,1))
text(L,
     labels = rownames(modelo),
     pos = 1)

### Analise Fatorial via componente principais com rotacao

modelo2 <- varimax(L)
L2 <- modelo2$loadings
L2

# Grafico das cargas fatoriais
plot(L2,pch = 20, col = "red", 
     xlab = "Cargas do fator 1", 
     ylab = "Cargas do fator 2",
     xlim=c(-1,1),ylim=c(-1,1))
text(L2,
     labels = rownames(modelo),
     pos = 3)

# comparação Cargas 1 e 2
cargas <- cbind(L,L2)
row.names(cargas) <-  row.names(R)
colnames(cargas) <- c("modelo1_F1","modelo1_F2","modelo2_F1","modelo2_F2")
print(cargas,3)


# MODELO FATORIAL PACOTE PSYCH --------------------------------------------

## Obtencao dos fatores por Componentes Principais 
fa1<-principal(R,nfactors = 2, rotate = "none")
fa1


##Quantidade de fatores
scree(R)



# Metodo de COmponentes Principais - 2 fatores
fa_cp<-principal(R,nfactors = 2, rotate = "varimax")
fa_cp

#Modelo Escolhido fa_cp
plot(fa_cp, labels = colnames(dados_educacionais),
     cex=0.8,
     ylim=c(-1.5,1))

fa.diagram(fa_cp)

# Fator 1 (Porte e eficiencia de consumo): wt disp  -mpg  -drat
# Fator 2 (Desempenho): -qsec hp

#Análise dos Scores - metodo de regressao
scores <- factor.scores(dados_car,fa_cp, method="Thurstone")

dados_car_fj<-cbind(dados_car,scores$scores)
head(dados_car_fj)

##Ranking do Fator 1
dados_car_fj$rank<-rank(dados_car_fj$RC1)

# Para entender o sentido do rank vamos avaliar o primeiro x ultimo individo
r1 <- dados_car_fj[dados_car_fj$rank==1,]
r32 <- dados_car_fj[dados_car_fj$rank==32,]
tab_rank <- rbind(r1,r32)
tab_rank

# Podemos ainda avaliar os casos de acordo com as variaveis
wt_disp <- dados_car_fj[,c("wt","disp","rank")]
plot(wt_disp$rank,wt_disp$wt)
#text(wt_disp$rank,wt_disp$wt,labels = row.names(wt_disp))

mpg_drat <- dados_car_fj[,c("mpg","drat","rank")]
plot(mpg_drat$rank,mpg_drat$mpg)




