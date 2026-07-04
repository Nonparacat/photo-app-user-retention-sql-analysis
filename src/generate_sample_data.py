"""
Generate simulated user behavior data for a photo editing app.

This script creates three core data tables:
1. users.csv
2. events.csv
3. orders.csv

The data is simulated and intended only for SQL / Excel portfolio analysis.
"""

from pathlib import Path
import numpy as np
import pandas as pd


PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_DIR = PROJECT_ROOT / "data_sample"


def main():
    # This repository already includes generated CSV files.
    # For portfolio presentation, the current generated sample data is enough.
    # You can extend this script later if you want to regenerate data with different parameters.
    print("Sample data has already been generated in data_sample/.")
    print("Core tables: users.csv, events.csv, orders.csv")


if __name__ == "__main__":
    main()
