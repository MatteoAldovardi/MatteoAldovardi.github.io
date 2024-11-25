#!/bin/bash

# Name of the environment
ENV_NAME="quarto_env"

# Check if the environment already exists
if conda info --envs | grep -q "$ENV_NAME"; then
    echo "Environment '$ENV_NAME' already exists. Activating it."
else
    # Create the environment
    echo "Creating a new environment '$ENV_NAME' with Python 3.9"
    conda create -n $ENV_NAME python=3.9 -y
fi

# Activate the environment
echo "Activating the environment '$ENV_NAME'..."
source $(conda info --base)/etc/profile.d/conda.sh
conda activate $ENV_NAME

# Verify if the environment is activated
if [[ "$CONDA_DEFAULT_ENV" == "$ENV_NAME" ]]; then
    echo "Environment '$ENV_NAME' is activated. Installing required packages..."
else
    echo "Failed to activate the environment '$ENV_NAME'. Exiting."
    exit 1
fi

# Install the required packages
echo "Installing required packages..."
conda install -y sympy matplotlib ipywidgets numpy

# Verify the installation
echo "Verifying the installation of the packages..."
python -c "import sympy, matplotlib, ipywidgets, numpy; print('All required packages are installed successfully!')"

# Success message
echo "Environment setup is complete, and the packages are installed."
