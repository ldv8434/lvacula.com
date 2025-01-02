#!/bin/bash
# Generated by Google Gemini 1.5 on 2025-01-02

# Function to extract the title from a file
extract_title() {
  grep "^title =" "$1" | sed 's/^title = "//' | sed 's/"$//' | tr -d '\r'
}

# Check if the "content" directory exists
if [[ ! -d "content/posts" ]]; then
  echo "Error: 'content/posts' directory not found." >&2
  exit 1
fi

# Find all .md files in the "content" directory recursively
find content -type f -name "*.md" 2>/dev/null | while read file; do
  title=$(extract_title "$file")

  # Skip files with 4 or 6 character ISO date titles
  if [[ ! -z "$title" ]] && [[ ! "$title" =~ ^[0-9]{4}(-[0-9]{2})?$ ]]; then
    printf "%s\t%s\n" "$title" "$file"
  fi
done | {

  selected=$(fzf --delimiter='\t' --layout=reverse --preview 'cat {2}' --preview-window='right:50%')

  if [[ -n "$selected" ]]; then
    filepath=$(echo "$selected" | awk -F'\t' '{print $2}')
    # Open the file in the editor using exec or by redirecting to /dev/tty
    #exec "$EDITOR" "$filepath" # Most robust solution
    #OR
    "$EDITOR" "$filepath" </dev/tty >/dev/tty 2>/dev/tty # Alternative solution
  fi
}