# QuickGuide | AWS SES

## Setup

### Register domain name

Use an existing domain or create one in route53

### Verify domain

SES console > domains > verify new domain > generate DKIM settings > verify domain > save DNS records > setup DNS records on route53 (or domain registrar)

### Verify email address

SES console > email addresses > verify a new email address > enter an email address of your choice > verify this email address

### Send test email via console

SES console > domains > select your domain > send test message > write message and send > check inbox to verify delivery

### Send test email via SMTP

SES console > SMTP settings > Create SMTP credentials > Create new IAM user

Spin up ec2 > install and configure postfix > install mailx > run below command to send email

```bash
echo "This message was sent using Amazon SES." | mailx -r test@domain.com -s "Test mail from cli" verified@email.com
```

### Enable bounce, complaints & delivery notifications

SES console > domains > select domain > view details > notifications > edit configuration > SNS Topic Configuration - select topic and checkmark include original headers > save

### Simulate email bounce

Send email to bounce@simulator.amazonses.com

```bash
echo "This message was sent using Amazon SES." | mailx -r test@domain.com -s "Test mail from cli" bounce@simulator.amazonses.com
```

### Email delivery failures

#### Permanent / Hard bounce

- General
- No email
- Suppressed

#### Transient / Soft bounce

- General
- Mailbox full
- Message too large
- Content rejected
- Attachment rejected

#### Rejected message

SES did not attempt to deliver this message because it contained a virus or malformed content.

### Getting out of sandbox

#### Case Description

1. About us
2. Email list size
3. How addresses get on the list
4. How addresses get off the list

### Lambda function to handle SES bounces

