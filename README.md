# Strategic Cost-based Optimization of Cyber Defense in Variable Constraints Systems

This project implements a MATLAB-based simulation to optimize the distribution of resources across nodes in a network. The simulation considers both resource criticality and cyber risk, aiming to reduce defense costs while maintaining an acceptable level of security.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Simulation Workflow](#simulation-workflow)
- [Model Comparison](#model-comparison)
- [Parameters](#parameters)
- [Plot Generation](#plot-generation)
- [Contributing](#contributing)
- [License](#license)
- [References](#references)

---

## Features

- **Resource Initialization**: Define resources manually or generate them randomly with specified maximum, minimum, and criticality deviation values.
- **Resource Distribution**: Iteratively distribute resources across nodes to minimize defense costs.
- **Cyber Risk Management**: Maintain the same level of cyber risk during resource optimization.
- **Model Comparison**: Generate plots to compare the current model with:
  - A baseline model without criticality considerations.
  - The model presented by Feng, Xiaotao et al. in the paper "A Signaling Game Model for Moving Target Defense."

---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/resource-distribution-optimization.git
   cd resource-distribution-optimization
   ```

2. **Set Up MATLAB**:
   - Ensure MATLAB is installed on your system.
   - Add the project directory to MATLAB’s path:
     ```matlab
     addpath(genpath('path_to_project_directory'));
     ```

---

## Usage

1. **Configure Simulation Parameters**:
   - Open one of the four (`main.m`) files and set the following parameters:
     - Number of nodes
     - Resource set or random generation range
     - Number of attacks
     - Criticality deviation

2. **Run the Simulation**:
   ```matlab
   main
   ```
   ```matlab
   main_vary_Mean
   ```
   ```matlab
   main_vary_R
   ```
   ```matlab
   main_vary_TR
   ```

3. **View Results**:
   - The simulation will generate plots comparing different models and save them to the project directory.

---

## Simulation Workflow

1. **Define Resources and Nodes**:
   - Resources can be manually defined or randomly generated within a specified range.
   - Nodes represent network points where resources are placed and may face attacks.

2. **Resource Distribution**:
   - The code iterates over nodes to optimize resource placement based on defense costs and cyber risk.

3. **Model Comparison**:
   - The simulation compares the performance of the current model to:
     - A model that does not consider resource criticality.
     - The signaling game model described by Feng et al.

---

## Model Comparison

The simulation evaluates the following models:

1. **Optimized Model**:
   - Uses resource criticality to optimize defense costs.

2. **Baseline Model**:
   - Distributes resources without considering criticality.

3. **Signaling Game Model**:
   - Based on the research by Feng, Xiaotao; Zheng, Zizhan; Cansever, Derya; Swami, Ananthram; and Mohapatra, Prasant:  
     _"A Signaling Game Model for Moving Target Defense."_

---

## Parameters

The simulation allows customization of various parameters:

| Parameter             | Description                                             |
|-----------------------|---------------------------------------------------------|
| `n`                   | Number of nodes in the network                          |
| `m`                   | Total number of resources                               |
| `deviation`           | Spread of resource criticalities                        |

---

## Plot Generation

- The simulation generates and saves plots that illustrate:
  - Resource distribution across nodes.
  - Defense cost comparisons between models.
  - The impact of varying parameters such as node count, resource count, and criticality deviation.
  
Saved plots are located in the same directory as the MATLAB code.

---

## Contributing

We welcome contributions to improve this project. To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add YourFeature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a Pull Request.

---

## References

- Feng, Xiaotao; Zheng, Zizhan; Cansever, Derya; Swami, Ananthram; Mohapatra, Prasant:  
  _"A Signaling Game Model for Moving Target Defense."_  
  [Link to paper]([https://example.com](https://ieeexplore.ieee.org/document/8057200))

For further questions or support, contact [jamil Ahmad Kassem](mailto:jamilahkassem@gmail.com).

---

*Note: Replace placeholders like `your-username`, `path_to_project_directory`, and the reference link with actual details for your project.*
