# Network Meta-Analysis and its role in evidence-based decision-making
# Frequentist and Bayesian Approaches in R

# if any of the following packages are not installed yet on your R environment, just use the code below:
# install.packages("package_that_you_need")

# Load required libraries
library(netmeta)
library(multinma)
library(ggplot2)
library(dplyr)
library(gridExtra)

# =============================================================================
# PART 1: FREQUENTIST APPROACH USING NETMETA PACKAGE
# =============================================================================

cat("=== FREQUENTIST NETWORK META-ANALYSIS USING NETMETA ===\n")

# Load the Stowe2010 dataset
data(Stowe2010)
head(Stowe2010)

# Data structure for conducting NMA
data <- pairwise(treat = list(t1, t2, t3),
                 n = list(n1, n2, n3),
                 mean = list(y1, y2, y3),
                 sd = list(sd1, sd2, sd3),
                 studlab = study,
                 data = Stowe2010)

# Create the network meta-analysis object
nma_freq <- netmeta(TE = TE,
                    seTE = seTE,
                    treat1 = treat1,
                    treat2 = treat2,
                    studlab = study,
                    data = data,
                    sm = "MD",
                    reference.group = "placebo",
                    common = FALSE, 
                    details.chkmultiarm = TRUE)

# Print summary of the network meta-analysis
print(nma_freq)
summary(nma_freq)

# 1. EVIDENCE NETWORK PLOT
cat("\n1. Plotting Evidence Network...\n")

# Plot the network
png("evidence_network_freq.png", width = 800, height = 600, res = 100)
netgraph(nma_freq, 
         plastic = FALSE,
         thickness = "number.of.studies",
         multiarm = TRUE,
         points = TRUE,
         col = "black",
         number.of.studies = TRUE)
title("Evidence Network - Frequentist Approach")
dev.off()

# Display network characteristics
cat("Network contains", nma_freq$k, "studies and", nma_freq$n, "treatments\n")
cat("Total number of possible pairwise comparisons:", nma_freq$m, "\n")
cat("Number of designs:", length(unique(nma_freq$designs)), "\n")

# 2. FOREST PLOTS
cat("\n2. Creating Forest Plots...\n")

# Forest plot for all comparisons vs reference
png("forest_plot_freq.png", width = 1000, height = 800, res = 100)
forest(nma_freq, reference.group = c("C", "D", "M"), drop.reference.group = FALSE)
dev.off()

# Forest plot for specific comparison
png("forest_plot_specific.png", width = 1000, height = 600, res = 100)
forest(nma_freq)
dev.off()

# 3. RANKOGRAMS
cat("\n3. Creating Rankograms...\n")

# Calculate treatment rankings
rank_freq <- rankogram(nma_freq, nsim = 1000)
print(rank_freq)

# Plot rankograms
png("rankogram_freq.png", width = 1200, height = 800, res = 100)
plot(rank_freq, 
     main = "Rankograms - Frequentist Approach")
dev.off()

# SUCRA (Surface Under the Cumulative Ranking curve) values
sucra_freq <- rank_freq$ranking.random
print("SUCRA values:")
print(sucra_freq)

# 4. HETEROGENEITY ASSESSMENT
cat("\n4. Assessing Heterogeneity...\n")

# Overall heterogeneity
cat("Overall heterogeneity (tau-squared):", round(nma_freq$tau^2, 4), "\n")
cat("Overall heterogeneity (tau):", round(nma_freq$tau, 4), "\n")
cat("I-squared:", round(nma_freq$I2, 1), "%\n")

# Decomposition of heterogeneity by design
decomp_design <- decomp.design(nma_freq)
print(decomp_design)


# 5. CONSISTENCY CHECKING
cat("\n5. Consistency Checking...\n")

# Net splitting approach
netsplit_result <- netsplit(nma_freq)
print(netsplit_result)

# Plot net splitting results
png("netsplit_plot.png", width = 1000, height = 800, res = 100)
forest(netsplit_result, 
       show = "all",
       col.inside = "blue",
       col.outside = "red")
dev.off()

# Network heat plot for inconsistency
png("netheat_plot.png", width = 1000, height = 800, res = 100)
netheat(nma_freq, 
        random = TRUE, nchar.trts = 4)
dev.off()


# =============================================================================
# PART 2: BAYESIAN APPROACH USING MULTINMA PACKAGE
# =============================================================================

cat("\n\n=== BAYESIAN NETWORK META-ANALYSIS USING MULTINMA ===\n")

# Load the parkinsons dataset
data(parkinsons)
head(parkinsons)

# 1. SET UP THE NETWORK
cat("\n1. Setting up the Network...\n")

# Set up the network using set_agd_arm()
park_net <- set_agd_arm(parkinsons,
                        study = studyn,
                        trt = trtn,
                        y = y,
                        se = se,
                        sample_size = n)

print(park_net)

# Plot the evidence network
png("evidence_network_bayes.png", width = 800, height = 600, res = 100)
plot(park_net, 
     weight_edges = TRUE,
     weight_nodes = TRUE,
     show_trt_class = FALSE) +
  ggtitle("Evidence Network - Bayesian Approach")
dev.off()

# 2. CONDUCT NMA USING FIXED AND RANDOM EFFECTS MODELS
cat("\n2. Conducting NMA with Fixed and Random Effects Models...\n")

# Fixed Effects Model
nma_fe <- nma(park_net,
              trt_effects = "fixed",
              prior_intercept = normal(scale = 100),
              prior_trt = normal(scale = 10))

print(nma_fe)

# Random Effects Model
nma_re <- nma(park_net,
              trt_effects = "random",
              prior_intercept = normal(scale = 100),
              prior_trt = normal(scale = 100),
              prior_het = half_normal(scale = 5))

print(nma_re)

# 3. MODEL COMPARISON: DIC AND RESIDUAL DEVIANCE
cat("\n3. Model Comparison - DIC and Residual Deviance...\n")

# Extract DIC values
(dic_fe <- dic(nma_fe))
(dic_re <- dic(nma_re))


# Plot residual deviance contributions
png("resdev_contrib.png", width = 1000, height = 600, res = 100)
plot(dic_fe, type = "resdev") +
  ggtitle("Residual Deviance Contributions")
dev.off()

# 4. CONSISTENCY CHECKING WITH UME MODELS
cat("\n4. Consistency Checking with UME Models...\n")

# Unrelated Mean Effects (UME) model
nma_ume <- nma(park_net,
               consistency = "ume",
               trt_effects = "random",
               prior_intercept = normal(scale = 100),
               prior_trt = normal(scale = 100),
               prior_het = half_normal(scale = 5))

print(nma_ume)

# Plot dev-dev plot for consistency checking
png("devdev_plot.png", width = 800, height = 600, res = 100)

# Compute the DIC for our UME model
(dic_ume <- dic(nma_ume)) 

# dev-dev plot
plot(dic_re, dic_ume, alpha = 0.5) +
  ggtitle("Dev-Dev Plot: Consistency vs UME Model")
dev.off()

# for a better observation of residual deviance points
plot(dic_re, dic_ume, show_uncertainty = FALSE)


# 5. PRIOR-POSTERIOR PLOTS
cat("\n5. Prior-Posterior Visualization...\n")

# Plot prior vs posterior distributions
png("prior_posterior.png", width = 1200, height = 800, res = 100)
plot_prior_posterior(nma_fe) +
  ggtitle("Prior vs Posterior Distributions")
dev.off()


# 6. RELATIVE EFFECTS
cat("\n6. Relative Effects...\n")

# Calculate relative effects
(rel_eff <- relative_effects(nma_fe, 
                            trt_ref = 1))

# Plot relative effects
png("relative_effects.png", width = 1000, height = 800, res = 100)
plot(rel_eff, 
     ref_line = 0)
dev.off()

# 7. TREATMENT RANKING
cat("\n7. Treatment Ranking...\n")

# Calculate treatment rankings
rank_bayes <- posterior_ranks(nma_fe,
                              lower_better = FALSE)
print(rank_bayes)

# Plot treatment rankings
png("treatment_ranking.png", width = 1000, height = 600, res = 100)
plot(rank_bayes) +
  ggtitle("Treatment Rankings")
dev.off()

# 8. CUMULATIVE RANKING PROBABILITIES
cat("\n8. Cumulative Ranking Probabilities...\n")

# Calculate cumulative ranking probabilities
cum_rank <- posterior_rank_probs(nma_fe,
                                 cumulative = TRUE)
print(cum_rank)

# Plot cumulative ranking probabilities
png("cumulative_ranking.png", width = 1200, height = 800, res = 100)
plot(cum_rank) +
  ggtitle("Cumulative Ranking Probabilities")
dev.off()

# Surface Under the Cumulative Ranking curve (SUCRA)
sucra_bayes <- posterior_rank_probs(nma_re,
                                   sucra = TRUE)
print("SUCRA values (Bayesian):")
print(sucra_bayes)

# =============================================================================
# SUMMARY AND COMPARISON
# =============================================================================

cat("\n\n=== SUMMARY AND COMPARISON ===\n")

# Compare SUCRA values from both approaches
cat("SUCRA Comparison:\n")
cat("Frequentist approach (netmeta):\n")
print(sucra_freq)
cat("\nBayesian approach (multinma):\n")
print(sucra_bayes)

# Model fit comparison for Bayesian models
cat("\nBayesian Model Comparison:\n")
cat("Fixed Effects DIC:", round(dic_fe$dic, 2), "\n")
cat("Random Effects DIC:", round(dic_re$dic, 2), "\n")
cat("Better model:", ifelse(dic_re$dic < dic_fe$dic, "Random Effects", "Fixed Effects"), "\n")


cat("\n=== TUTORIAL COMPLETE ===\n")
cat("All plots have been saved as PNG files in your working directory.\n")
cat("Key files created:\n")
cat("- evidence_network_freq.png\n")
cat("- forest_plot_freq.png\n")
cat("- rankogram_freq.png\n")
cat("- decomp_design.png\n")
cat("- netsplit_plot.png\n")
cat("- netheat_plot.png\n")
cat("- evidence_network_bayes.png\n")
cat("- resdev_contrib.png\n")
cat("- devdev_plot.png\n")
cat("- prior_posterior.png\n")
cat("- relative_effects.png\n")
cat("- treatment_ranking.png\n")
cat("- cumulative_ranking.png\n")