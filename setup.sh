echo '
#!/bin/bash

target_url=$1
robots_txt_url="$target_url/robots.txt"
disallowed_pages=()

response_code=$(curl -sL -w "%{http_code}" "$robots_txt_url" -o /dev/null)

if [[ $response_code -eq 200 ]]; then
  disallowed_pages=($(curl -sL "$robots_txt_url" | grep -oP "(?<=Disallow: ).*"))

  if [[ ${#disallowed_pages[@]} -eq 0 ]]; then
   echo "Cant find No-Indexed Pages."
  else
    echo "Not-Indexed Pages:"
    for page in "${disallowed_pages[@]}"; do
      echo "$page"
    done
  fi
else
  echo "robots.txt Not Found."
fi
' > nipst
chmod +x nipst
mv ./nipst ../nipst
cd ~
echo "Use with: ./nipst website.com"
break
