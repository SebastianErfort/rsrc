# ---
# tags: [bash, variables, bash/variables]
# ---

# Assign Heredoc value to variable
read -r -d '' VAR <<'EOF'
foo bar
EOF
# or
VAR=$(cat <<'EOF'
what the frak
EOF
)
