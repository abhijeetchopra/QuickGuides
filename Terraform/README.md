# QuickGuide | Terraform

```bash

# save plan output to file
terraform plan | tee -a outfile

# remove ANSI escape and color characters
cat outfile | gsed -r "s/[[:cntrl:]]\[[0-9]{1,3}m//g" > outfileclean

# grep for additions/modifications/removals

cat outfileclean | grep -e "^  +" -e "^  ~" -e "^  -"

```
