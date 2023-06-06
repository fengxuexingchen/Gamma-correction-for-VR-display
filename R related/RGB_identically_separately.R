setwd("E:/我的坚果云/SNNU/论文修改/color calibration in VR/R related")

options(scipen = 999)
options(contrasts = c("contr.sum", "contr.poly"))

library(readxl)
raw_data <- read_excel("E:/我的坚果云/SNNU/论文修改/color calibration in VR/measurement - RMS.xlsx",sheet = "RGB_identically_separately")




raw_data$channel <- factor(raw_data$channel, levels=c("R", "G", "B", "A"),labels = c("Red", "Green", "Blue", "Achromatic"))
raw_data$correction <- factor(raw_data$correction, levels=c("identically", "separately"),labels = c("RGB channels (achromatic)", "R, G, and B channel (chromatic)"))

# the value is calculated manually. For example, for the last value,Y=0 is the value when RGB=(0,0,0)， 
# Z=0.5773031 is (147.2123-0)/255, of which 147.2123 is the value when RGB=(255,255,255)
dummy2 <- data.frame(channel = c("Red", "Green", "Blue", "Achromatic"), Z = c(0.15584,0.2645435,0.0259702,0.5773031), Y=c(0,0,0,0))

library(ggplot2)
ggplot(raw_data) + 
  geom_line(aes(x=RGB, y=cdm2, color=channel, linetype=correction),size=1) +
  scale_colour_manual(values = c("Red" = "red", "Green" = "green", "Blue" = "blue", "Achromatic" = "gray")) +    #gray70, gray30
  scale_linetype_manual(values = c("RGB channels (achromatic)" = "dashed", "R, G, and B channel (chromatic)" = "dotted")) +
  scale_x_continuous(breaks = c(0,32,64,96,128,160,192,224,255)) +
  facet_wrap(channel~.,scales="free",nrow = 2) +
  theme_bw()+
  theme(
    strip.background = element_rect(fill="black"),
    strip.text = element_text(colour = "white", size = 25),   #20
    panel.grid = element_blank(),
    text = element_text(size=30,face = "bold"),  #16
    plot.margin = margin(2, 2, 2, 2, "mm"),
    legend.position = 'none'  ,   # c(0.9,0.98)   'none'
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
  guides(color=guide_legend(title="Channel"),linetype=guide_legend(title="Corrected channel")) +
  geom_abline(data = dummy2, aes(intercept = Y, slope = Z), color="orange", linetype="solid", size=1) 



  
  
#######################calculate the difference between actual values and fitted values

a = c(0.15584,0.2645435,0.0259702,0.5773031)  #slope
b = c(0,0,0,0)   #intercept
RGB_value = c(0,32,64,96,128,160,192,224,255)
#Achromatic
identically_value <- raw_data[which(raw_data$correction == 'RGB channels (achromatic)'  & raw_data$channel == 'Achromatic'),'cdm2']
separately_value <- raw_data[which(raw_data$correction == 'R, G, and B channel (chromatic)'  & raw_data$channel == 'Achromatic'),'cdm2']
identically_difference <- matrix(nrow = 9, ncol = 1) 
separately_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  identically_difference[i] <- abs(b[4]+a[4]*RGB_value[i]-identically_value$cdm2[i])
  separately_difference[i] <- abs(b[4]+a[4]*RGB_value[i]-separately_value$cdm2[i])
}
sum(identically_difference)
sum(separately_difference)
#Red
identically_value <- raw_data[which(raw_data$correction == 'RGB channels (achromatic)'  & raw_data$channel == 'Red'),'cdm2']
separately_value <- raw_data[which(raw_data$correction == 'R, G, and B channel (chromatic)'  & raw_data$channel == 'Red'),'cdm2']
identically_difference <- matrix(nrow = 9, ncol = 1) 
separately_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  identically_difference[i] <- abs(b[1]+a[1]*RGB_value[i]-identically_value$cdm2[i])
  separately_difference[i] <- abs(b[1]+a[1]*RGB_value[i]-separately_value$cdm2[i])
}
sum(identically_difference)
sum(separately_difference)
#Green
identically_value <- raw_data[which(raw_data$correction == 'RGB channels (achromatic)'  & raw_data$channel == 'Green'),'cdm2']
separately_value <- raw_data[which(raw_data$correction == 'R, G, and B channel (chromatic)'  & raw_data$channel == 'Green'),'cdm2']
identically_difference <- matrix(nrow = 9, ncol = 1) 
separately_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  identically_difference[i] <- abs(b[2]+a[2]*RGB_value[i]-identically_value$cdm2[i])
  separately_difference[i] <- abs(b[2]+a[2]*RGB_value[i]-separately_value$cdm2[i])
}
sum(identically_difference)
sum(separately_difference)
#Blue
identically_value <- raw_data[which(raw_data$correction == 'RGB channels (achromatic)'  & raw_data$channel == 'Blue'),'cdm2']
separately_value <- raw_data[which(raw_data$correction == 'R, G, and B channel (chromatic)'  & raw_data$channel == 'Blue'),'cdm2']
identically_difference <- matrix(nrow = 9, ncol = 1) 
separately_difference <- matrix(nrow = 9, ncol = 1) 
for (i in 1:length(RGB_value)){
  identically_difference[i] <- abs(b[3]+a[3]*RGB_value[i]-identically_value$cdm2[i])
  separately_difference[i] <- abs(b[3]+a[3]*RGB_value[i]-separately_value$cdm2[i])
}
sum(identically_difference)
sum(separately_difference)


