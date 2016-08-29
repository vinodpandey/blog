


## Processing Logs
```sh
# access per day 
awk '{print $4}' example.com | cut -d: -f1 | uniq -c

# access per hour
grep "23/Jan" example.com | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c

# access per minute
grep "23/Jan/2013:06" example.com | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":"$3}' | sort -nk1 -nk2 | uniq -c | awk '{ if ($1 > 10) print $0}'
```
