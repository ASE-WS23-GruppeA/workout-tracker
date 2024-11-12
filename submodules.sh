#!/usr/bin/env bash

# Initialize and update all submodules recursively
echo "Initializing and updating all submodules..."
git submodule update --init --recursive

# Loop through all submodules to ensure they track the correct branch
git submodule foreach '
  branch=$(git config -f $toplevel/.gitmodules submodule.$name.branch);
  if [ -n "$branch" ]; then
    echo "Checking out branch $branch for submodule $name";
    git checkout $branch || {
      echo "Branch $branch not found for submodule $name. Skipping..."
    }
    git branch --set-upstream-to=origin/$branch $branch || {
      echo "Could not set upstream for submodule $name. Skipping..."
    }
  else
    echo "No branch specified in .gitmodules for submodule $name. Skipping..."
  fi
'

# Update all submodules to their latest commits from the tracked branches
echo "Updating submodules to the latest commit on their branches..."
git submodule update --remote --recursive

echo "All submodules initialized, updated, and set to track their respective branches."

