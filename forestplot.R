library(metafor)

df = read.table("MR.results.txt", T, sep = "\t")
z <- qnorm((1 + 0.95) / 2, 0, 1)

pdf("forest.pdf", width = 10, height = 12)
forest(
  df$estimate,
  sei = df$stderr,
  slab = sprintf("    %s", df$p1),
  xlab = "Odds ratio",
  annotate = FALSE,
  ilab = data.frame(
    sprintf("%.2f", exp(df$estimate)),
    sprintf("(%.2f, %.2f)", exp(df$estimate - z * df$stderr), exp(df$estimate + z * df$stderr)),
    sprintf("%.2e", df$p)),
  ilab.xpos = c(3, 3.5, 4.25),
  pch = 16,
  atransf = exp,
  at = log(c(0.5, 1, 2, 4, 8, 16)),
  rows = rev(c(0, 3, 6:8, 11:13, 16:19, 22:25, 28:30, 33:37)),
  xlim = c(-2, 4.75),
  ylim = c(0, 41)
)

# plot disease labels
par(font=2)
text(-2, c(38, 31, 26, 20, 14, 9, 4, 1), pos=4, unique(df$p2))

dev.off()
