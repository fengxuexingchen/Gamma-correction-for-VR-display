setwd("E:/我的坚果云/SNNU/论文修改/color calibration in VR/R related")

options(scipen = 999)
options(contrasts = c("contr.sum", "contr.poly"))

library(readxl)
raw_data <- read_excel("E:/我的坚果云/SNNU/论文修改/color calibration in VR/measurement - photoresistor.xlsx",sheet = "photoresistor")




raw_data$channel <- factor(raw_data$channel, levels=c("R", "G", "B", "A"),labels = c("Red", "Green", "Blue", "Achromatic"))



library(ggplot2)


ggplot(raw_data) + 
  geom_line(aes(x=cdm2, y=voltage, color=channel),size=4) +
  geom_point(aes(x=cdm2, y=voltage, color=channel,shape=channel),size=8) +
  scale_colour_manual(values = c("Red" = "red", "Green" = "green", "Blue" = "blue", "Achromatic" = "gray")) +    #gray70, gray30
  scale_shape_manual(values = c("Red" = 15, "Green" = 16, "Blue" = 17, "Achromatic" = 18)) +
  theme_bw()+
  theme(
    strip.background = element_rect(fill="black"),
    strip.text = element_text(colour = "white", size = 25),   #20
    panel.grid = element_blank(),
    text = element_text(size=30,face = "bold"),  #16
    plot.margin = margin(2, 2, 2, 2, "mm"),
    legend.position = c(0.4,0.98),   # c(0.4,0.98)  'none'
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
  labs(x = "Value from photometer (cd/m2)", y = "Value from Arduino IDE (AU)") +
  guides(color=guide_legend(title="Channel"), shape=guide_legend(title="Channel"))
