# QuickGuide | Terraform

```bash

# save plan output to file
terraform plan | tee -a outfile

# remove ANSI escape and color characters
cat outfile | gsed -r "s/[[:cntrl:]]\[[0-9]{1,3}m//g" > outfileclean

# grep for additions/modifications/removals
cat outfileclean | grep -e "^  +" -e "^  ~" -e "^  -"

# generate param string to tack to 'terraform apply' with pre-populated targets
# note: modify grep expressions according to your need
cat outfileclean | grep -e "^  +" -e "^  ~" -e "^  -" | grep launch_template | awk '{print $2}' | sed 's/^/-target /' | xargs

# query terraform state to get a list of fqdns of all route53 records present
terraform show -json | jq '.values.root_module.resources[] | select(.type == "aws_route53_record").values.fqdn' | jq -r | sort | cat -n

```
