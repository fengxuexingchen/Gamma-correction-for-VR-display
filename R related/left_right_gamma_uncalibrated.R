setwd("E:/我的坚果云/SNNU/论文修改/color calibration in VR/R related")

options(scipen = 999)
options(contrasts = c("contr.sum", "contr.poly"))

library(readxl)
raw_data <- read_excel("E:/我的坚果云/SNNU/论文修改/color calibration in VR/measurement - RMS.xlsx",sheet = "left_right_gamma_uncalibrated")




raw_data$channel <- factor(raw_data$channel, levels=c("R", "G", "B", "A"),labels = c("Red", "Green", "Blue", "Achromaticity"))
raw_data$position <- factor(raw_data$position, levels=c("left", "right"),labels = c("Left eye", "Right eye"))



library(ggplot2)


ggplot(raw_data) + 
  geom_line(aes(x=RGB, y=cdm2, color=channel, linetype=position),size=4) +
  scale_colour_manual(values = c("Red" = "red", "Green" = "green", "Blue" = "blue", "Achromaticity" = "gray")) +    #gray70, gray30
  scale_linetype_manual(values = c("Left eye" = "dashed", "Right eye" = "dotted")) +
  scale_x_continuous(breaks = c(0,32,64,96,128,160,192,224,255)) +
  theme_bw()+
  theme(
    strip.background = element_rect(fill="black"),
    strip.text = element_text(colour = "white", size = 25),   #20
    panel.grid = element_blank(),
    text = element_text(size=30,face = "bold"),  #16
    plot.margin = margin(2, 2, 2, 2, "mm"),
    legend.position = c(0.9,0.98),   # c(0.9,0.98)   'none'
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
  guides(color=guide_legend(title="Channel"),linetype=guide_legend(title="VR display"))
