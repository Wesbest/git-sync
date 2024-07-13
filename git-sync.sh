#!/bin/zsh

# Fetch the latest updates from the remote and prune deleted branches
git fetch -p

# List all local branches that are not tracking remote branches or the main branch
branches_to_delete=$(git branch -a | grep -vE 'remotes/origin/|main|master' | awk '{print $1}')

# Check if there are any branches to delete
if [ -z "$branches_to_delete" ]; then
    echo "Everything is in sync with the remote."
else
    echo "The following branches are local only and can be deleted:"
    echo "$branches_to_delete"sour
    echo

    # Prompt the user to confirm deletion
    read "confirm?Do you want to delete these branches? (y/n): "

    if [ "$confirm" = "y" ]; then
        # Delete the local branches that are not tracking remote branches or the main branch
        echo "$branches_to_delete" | xargs -r git branch -d
        echo "Branches deleted."
    else
        echo "No branches were deleted."
    fi
fi
