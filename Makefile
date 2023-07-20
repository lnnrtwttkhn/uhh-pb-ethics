# Makefile to create a Python virtual environment

# Name of the virtual environment (change this as desired)
VENV_NAME := venv

# Python executable (change this if your Python executable is named differently)
PYTHON := python3

# Install required packages
install:
	$(PYTHON) -m venv $(VENV_NAME)
	@echo "Virtual environment '$(VENV_NAME)' created."
	@echo "Activating virtual environment..."
	@echo "Run 'source $(VENV_NAME)/bin/activate' to activate the virtual environment."
	@echo "Installing required packages..."
	$(VENV_NAME)/bin/pip install -r requirements.txt

# Update required packages (if needed)
update:
	$(VENV_NAME)/bin/pip install -U -r requirements.txt

# Create or update requirements.txt
requirements:
	$(VENV_NAME)/bin/pip freeze > requirements.txt
	@echo "requirements.txt updated."

# Remove the virtual environment
clean:
	rm -rf $(VENV_NAME)
	@echo "Virtual environment removed."

template-full-proposal.pdf: template-full-proposal.tex config.tex style.sty
	latexmk -xelatex main.tex

config.tex: config.py config.yml
	$(VENV_NAME)/bin/python config.py

# Display available make commands
help:
	@echo "Available make commands:"
	@echo "  install     : Create a virtual environment and install required packages."
	@echo "  update      : Update the installed packages in the virtual environment (using requirements.txt)."
	@echo "  requirements: Create or update requirements.txt based on the current virtual environment."
	@echo "  clean       : Remove the virtual environment."
	@echo "  help        : Display this help message."

.PHONY: install update requirements clean help run
