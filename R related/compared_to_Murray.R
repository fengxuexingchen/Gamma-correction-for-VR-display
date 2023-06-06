setwd("E:/我的坚果云/SNNU/论文修改/color calibration in VR/R related")

options(scipen = 999)
options(contrasts = c("contr.sum", "contr.poly"))

library(readxl)
raw_data <- read_excel("E:/我的坚果云/SNNU/论文修改/color calibration in VR/measurement - RMS.xlsx",sheet = "compared_to_Murray")




raw_data$channel <- factor(raw_data$channel, levels=c("R", "G", "B", "A"),labels = c("Red", "Green", "Blue", "Achromatic"))
raw_data$correction <- factor(raw_data$correction, levels=c("Murray", "Hu"),labels = c("Murray et al. (2022)", "Current study"))


library(ggplot2)

# the value is calculated manually. For example, for the last value,Y=0.7683 is the value when RGB=(0,0,0) for Murray et al. (2022) 
# Z=0.5494612 is (140.8809-0.7683)/255, of which 140.8809 is the value when RGB=(255,255,255)
# Y=0, Z=0.5773031 are for current study

dummy2 <- data.frame(channel = c("Red", "Red","Green", "Green","Blue", "Blue","Achromatic","Achromatic"), 
                     Z = c(0.15584,0.1644894,0.2645435,0.280078,0.0259702,0.05987725,0.5773031,0.5494612),
                     Y= c(0,0.8012,0,2.1412,0,1.4247,0,0.7683))

library(ggplot2)
ggplot(raw_data) + 
  geom_line(aes(x=RGB, y=cdm2, color=channel, linetype=correction),size=1) +
  scale_colour_manual(values = c("Red" = "red", "Green" = "green", "Blue" = "blue", "Achromatic" = "gray")) +    #gray70, gray30
  scale_linetype_manual(values = c("Murray et al. (2022)" = "dashed", "Current study" = "dotted")) +
  scale_x_continuous(breaks = c(0,32,64,96,128,160,192,224,255)) +
  facet_wrap(channel~.,scales="free",nrow = 2) +
  theme_bw()+
  theme(
    strip.background = element_rect(fill="black"),
    strip.text = element_text(colour = "white", size = 25),   #20
    panel.grid = element_blank(),
    text = element_text(size=30,face = "bold"),  #16
    plot.margin = margin(2, 2, 2, 2, "mm"),
    legend.position = 'none' ,   # c(0.4,0.98)   'none'
    legend.justification = c("right", "top"),
    legend.box.just = "left",
    legend.margin = margin(6, 6, 6, 6, "mm"),
    legend.key.width=unit(2,"cm"),
    legend.text = element_text(size = 22),
    legend.title = element_text(size = 25),
    panel.background = element_rect(fill = "white"),
    axis.ticks = element_line(size = 2),
    axis.ticks.length = unit(0.25,"cm"),
    axis.text = element_text(size=25,color = "black")
  )  +
  labs(x = "RGB values", y = "Estimated luminance (cd/m2)") +
  guides(color=guide_legend(title="Channel"),linetype=guide_legend(title="Method")) +
  geom_abline(data = dummy2, aes(intercept = Y, slope = Z),color=c("orange","purple","orange","purple","orange","purple","orange","purple"),linetype="solid", size=1) 


#######################calculate the difference between actual values and fitted values

a = c(0.15584,0.1644894,0.2645435,0.280078,0.0259702,0.05987725,0.5773031,0.5494612)  #slope
b = c(0,0.8012,0,2.1412,0,1.4247,0,0.7683)   #intercept
RGB_value = c(0,32,64,96,128,160,192,224,255)
#Achromatic
Murray_value <- raw_data[which(raw_data$correction == 'Murray et al. (2022)'  & raw_data$channel == 'Achromatic'),'cdm2']
Hu_value <- raw_data[which(raw_data$correction == 'Current study'  & raw_data$channel == 'Achromatic'),'cdm2']
Murray_difference <- matrix(nrow = 9, ncol = 1) 
Hu_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  Murray_difference[i] <- abs(b[8]+a[8]*RGB_value[i]-Murray_value$cdm2[i])
  Hu_difference[i] <- abs(b[7]+a[7]*RGB_value[i]-Hu_value$cdm2[i])
}
sum(Murray_difference)
sum(Hu_difference)
#Red
Murray_value <- raw_data[which(raw_data$correction == 'Murray et al. (2022)'  & raw_data$channel == 'Red'),'cdm2']
Hu_value <- raw_data[which(raw_data$correction == 'Current study'  & raw_data$channel == 'Red'),'cdm2']
Murray_difference <- matrix(nrow = 9, ncol = 1) 
Hu_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  Murray_difference[i] <- abs(b[2]+a[2]*RGB_value[i]-Murray_value$cdm2[i])
  Hu_difference[i] <- abs(b[1]+a[1]*RGB_value[i]-Hu_value$cdm2[i])
}
sum(Murray_difference)
sum(Hu_difference)
#Green
Murray_value <- raw_data[which(raw_data$correction == 'Murray et al. (2022)'  & raw_data$channel == 'Green'),'cdm2']
Hu_value <- raw_data[which(raw_data$correction == 'Current study'  & raw_data$channel == 'Green'),'cdm2']
Murray_difference <- matrix(nrow = 9, ncol = 1) 
Hu_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  Murray_difference[i] <- abs(b[4]+a[4]*RGB_value[i]-Murray_value$cdm2[i])
  Hu_difference[i] <- abs(b[3]+a[3]*RGB_value[i]-Hu_value$cdm2[i])
}
sum(Murray_difference)
sum(Hu_difference)
#Blue
Murray_value <- raw_data[which(raw_data$correction == 'Murray et al. (2022)'  & raw_data$channel == 'Blue'),'cdm2']
Hu_value <- raw_data[which(raw_data$correction == 'Current study'  & raw_data$channel == 'Blue'),'cdm2']
Murray_difference <- matrix(nrow = 9, ncol = 1) 
Hu_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  Murray_difference[i] <- abs(b[6]+a[6]*RGB_value[i]-Murray_value$cdm2[i])
  Hu_difference[i] <- abs(b[5]+a[5]*RGB_value[i]-Hu_value$cdm2[i])
}
sum(Murray_difference)
sum(Hu_difference)