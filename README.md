# 🔬 Network Meta-Analysis and Its Role in Evidence-Based Decision-Making

<div align="center">

![R](https://img.shields.io/badge/R-4.0%2B-blue?style=for-the-badge&logo=r&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-orange?style=for-the-badge)

### *Master both Frequentist and Bayesian approaches to Network Meta-Analysis*

[📚 Tutorial](#-tutorial-overview) • [🚀 Quick Start](#-quick-start) • [📊 Examples](#-examples) • [🛠️ Installation](#️-installation) • [📖 Documentation](#-documentation)

---

</div>

## 🎯 What is Network Meta-Analysis?

Network Meta-Analysis (NMA) is a powerful statistical technique that allows researchers to compare multiple treatments simultaneously, even when some treatments have never been directly compared in head-to-head trials. This tutorial provides a comprehensive guide to conducting NMA using both **frequentist** and **Bayesian** statistical frameworks.

### 🔥 Why This Tutorial?

- **📈 Dual Approach**: Master both frequentist (`netmeta`) and Bayesian (`multinma`) methods
- **🎨 Rich Visualizations**: Generate professional plots including evidence networks, forest plots, and rankograms
- **🔍 Model Diagnostics**: Learn advanced techniques for heterogeneity assessment and consistency checking
- **📊 Real Data**: Work with actual clinical trial datasets (`Stowe2010` and `parkinsons`)
- **🎓 Educational**: Step-by-step explanations suitable for beginners to advanced users

## 📚 Tutorial Overview

<table>
<tr>
<td width="50%">

### 🔵 Frequentist Approach
**Package**: `netmeta`  
**Dataset**: `Stowe2010`

- ✅ Evidence network visualization
- ✅ Forest plots for treatment effects
- ✅ Rankograms and SUCRA values
- ✅ Heterogeneity decomposition
- ✅ Consistency checking with net-splitting
- ✅ Network heat maps

</td>
<td width="50%">

### 🔴 Bayesian Approach
**Package**: `multinma`  
**Dataset**: `parkinsons`

- ✅ Network setup with `set_agd_arm()`
- ✅ Fixed and Random Effects models
- ✅ DIC and residual deviance
- ✅ UME models for consistency
- ✅ Prior-posterior visualizations
- ✅ Treatment rankings and probabilities

</td>
</tr>
</table>

## 🚀 Quick Start

### Prerequisites

```r
# Install required packages
install.packages(c("netmeta", "multinma", "ggplot2", "dplyr", "gridExtra"))
```

### Run the Tutorial

```r
# Clone the repository
git clone https://github.com/dgalgom/NMA-webinar-r.git
cd NMA-webinar-r

# Run the main tutorial
source("NMA_webinar.R")
```

## 📊 Examples

### 🌐 Evidence Networks

<div align="center">

| Frequentist Network | Bayesian Network |
|:---:|:---:|
| ![evidence_network_freq](https://github.com/user-attachments/assets/66a7f487-facc-4384-856a-afc79e8e24d9) | ![evidence_network_bayes](https://github.com/user-attachments/assets/e4373fa9-1d3d-4997-b135-ffaee47e536b) |

</div>

### 📈 Treatment Rankings

<div align="center">

| Rankograms | Cumulative Probabilities |
|:---:|:---:|
|![rankogram_freq](https://github.com/user-attachments/assets/b87f41ad-0a8a-490a-a81f-8ce56f2b2e0e) | ![cumulative_ranking](https://github.com/user-attachments/assets/bdf3ccc6-ef9a-4967-af85-a7c7c003a280) |

</div>

## 🛠️ Installation

### System Requirements

- **R**: Version 4.0 or higher
- **RStudio**: Recommended for best experience
- **Operating System**: Windows, macOS, or Linux

### Package Dependencies

```r
# Core packages
library(netmeta)      # Frequentist NMA
library(multinma)     # Bayesian NMA
library(ggplot2)      # Plotting
library(dplyr)        # Data manipulation
library(gridExtra)    # Plot arrangements

# Additional packages (installed automatically)
# - meta, magic, MASS, coda, rjags, etc.
```

### Docker Setup (Optional)

```dockerfile
FROM rocker/tidyverse:latest

RUN R -e "install.packages(c('netmeta', 'multinma', 'gridExtra'))"

COPY . /home/rstudio/nma-tutorial
WORKDIR /home/rstudio/nma-tutorial
```

## 📖 Documentation

### 📋 File Structure

```
nma-tutorial-r/
├── 📄 README.md                 # This file
├── 📜 nma_tutorial.R            # Main tutorial script
├── 📊 data/                     # Sample datasets
├── 📈 outputs/                  # Generated plots
├── 📚 docs/                     # Additional documentation
│   ├── frequentist_guide.md     # Frequentist methods
│   ├── bayesian_guide.md        # Bayesian methods
│   └── interpretation_guide.md  # Results interpretation
├── 🧪 examples/                 # Additional examples
└── 🔧 utils/                    # Helper functions
```

### 🎯 Key Functions Overview

<details>
<summary><strong>Frequentist Functions (netmeta)</strong></summary>

| Function | Purpose | Output |
|----------|---------|--------|
| `netmeta()` | Conduct network meta-analysis | NMA object |
| `netgraph()` | Plot evidence network | Network visualization |
| `forest()` | Create forest plots | Treatment effects plot |
| `rankogram()` | Generate rankograms | Treatment ranking plot |
| `decomp.design()` | Assess heterogeneity | Heterogeneity breakdown |
| `netsplit()` | Check consistency | Consistency assessment |
| `netheat()` | Network heat map | Inconsistency visualization |

</details>

<details>
<summary><strong>Bayesian Functions (multinma)</strong></summary>

| Function | Purpose | Output |
|----------|---------|--------|
| `set_agd_arm()` | Set up network data | Network object |
| `nma()` | Conduct Bayesian NMA | NMA model |
| `plot()` | Visualize networks/results | Various plots |
| `relative_effects()` | Calculate treatment effects | Effect estimates |
| `posterior_ranks()` | Treatment rankings | Ranking probabilities |
| `plot_prior_posterior()` | Compare distributions | Prior vs posterior |

</details>

## 🎨 Generated Outputs

The tutorial generates **13 high-quality plots**:

### 📊 Frequentist Outputs
- `evidence_network_freq.png` - Network structure
- `forest_plot_freq.png` - Treatment effects
- `rankogram_freq.png` - Treatment rankings
- `decomp_design.png` - Heterogeneity decomposition
- `netsplit_plot.png` - Consistency checking
- `netheat_plot.png` - Network heat map

### 📈 Bayesian Outputs
- `evidence_network_bayes.png` - Network structure
- `resdev_contrib.png` - Residual deviance
- `devdev_plot.png` - Dev-dev plot
- `prior_posterior.png` - Prior vs posterior
- `relative_effects.png` - Treatment effects
- `treatment_ranking.png` - Rankings
- `cumulative_ranking.png` - Cumulative probabilities

### 🐛 Bug Reports

Found a bug? Please create an issue with:
- **Description**: Clear description of the problem
- **Reproducible Example**: Minimal code to reproduce the issue
- **Environment**: R version, package versions, OS
- **Expected vs Actual**: What you expected vs what happened

### 💡 Feature Requests

Have ideas for improvements? We'd love to hear them! Please include:
- **Use Case**: Why this feature would be useful
- **Description**: Detailed description of the proposed feature
- **Examples**: How it would work in practice

## 📊 Use Cases

This tutorial is perfect for:

- **👩‍🔬 Researchers** conducting systematic reviews and meta-analyses
- **👨‍⚕️ Clinicians** evaluating treatment effectiveness
- **🎓 Students** learning network meta-analysis methods
- **📊 Statisticians** comparing frequentist and Bayesian approaches
- **🏥 Health Technology Assessment** agencies

## 🔗 Resources

### 📚 Further Reading

- [Cochrane Handbook for Systematic Reviews](https://training.cochrane.org/handbook)
- [Network Meta-Analysis: An Introduction](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3138064/)
- [PRISMA-NMA Guidelines](http://www.prisma-statement.org/Extensions/NetworkMetaAnalysis)

### 🛠️ Related Tools

- [netmeta R package](https://cran.r-project.org/package=netmeta)
- [multinma R package](https://cran.r-project.org/package=multinma)
- [R-INLA](https://www.r-inla.org/) - Alternative Bayesian framework

## 📄 Citation

If you use this tutorial in your research, please cite:

```bibtex
@software{nma_tutorial_r,
  author = {Your Name},
  title = {Network Meta-Analysis in R: A Comprehensive Tutorial},
  url = {https://github.com/yourusername/nma-tutorial-r},
  year = {2025},
  version = {1.0.0}
}
```

## 🙋‍♂️ Support

Need help? Here's how to get support:

1. **📖 Documentation**: Check the [docs](docs/) folder
2. **💬 Discussions**: Use GitHub Discussions for questions
3. **🐛 Issues**: Report bugs via GitHub Issues
4. **📧 Email**: Contact [daniel.gallardo@iconplc.com](mailto:daniel.gallardo@iconplc.com)

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=dgalgom/NMA-webinar-r&type=Date)](https://star-history.com/#dgalgom/NMA-webinar-r&Date)

---

<div align="center">

### 🎉 Happy Analyzing! 

*Made with ❤️ by the ICON Clinical Research team*

[⬆️ Back to Top](#-network-meta-analysis-and-its-role-in-evidence-based-decision-making)

</div>
