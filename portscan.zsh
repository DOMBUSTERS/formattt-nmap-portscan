# portscan 10.129.61.113

portscan () {
    if (($# != 1)) || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
    then
        cat <<'EOF'
Start scaning ports using Nmap
Usage: portscan [ip]
EOF
        return
    fi
    ports=$( (sudo nmap -sS -p- --open --min-rate 5000 -vvv -n $1 | awk '$1 ~ /^[0-9]/ {print $1}' | cut -d '/' -f1 | tr '\n' ',' | sed s/,$//)) 
    sudo nmap -Pn -sC -sV -p$ports $1
}
