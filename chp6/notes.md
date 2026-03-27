
# Passwords And Things

Need to look into aws-vault:

```
  $ aws-vault add dev
  Enter Access Key Id: (YOUR_ACCESS_KEY_ID)
  Enter Secret Key: (YOUR_SECRET_ACCESS_KEY)
```

Then...

```
  $ aws-vault exec <PROFILE> -- <COMMAND>
```

So...


```
  $ aws-vault exec dev -- terraform apply
```

Could probably fish-alias the `aws-vault exec dev --` to something shorter...

This would keep the secrets out of plain-text env vars, files, etc.  Only
available to the process running the command I told it to run.

This is *better*.


## SOPS

Pro-tip....

You don't need to dork with shell scripts to edit a sops-encrypted file...

You literally just run `sops <filename>`, and it decrypts it and opens in your
$EDITOR, and when you save / quit, it encrypts the file...

Also: sops works with AWS KMS... and (obviously) PGP keys.

Also: terragrunt has a built-in `sops_decrypt_file` function...


## Conclusion

Just store secrets in AWS Secrets Manager, and use built-in terraform providers
for pulling out said secrets.  Better than any of these other options.

But it is interesting to note that a no-AWS-required approach could easily use
PGP keys and sops to store encypted secrets securely in version control.
