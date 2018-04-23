import smtplib
import email.mime.text
from szurubooru import config


def send_mail(sender: str, recipient: str, subject: str, body: str) -> None:
    msg = email.mime.text.MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = sender
    msg['To'] = recipient

    if config.config['smtp']['ssl']:
        smtp_f = smtplib.SMTP_SSL
    else:
        smtp_f = smtplib.SMTP
    smtp = smtp_f(
        config.config['smtp']['host'], int(config.config['smtp']['port']))
    smtp.ehlo_or_helo_if_needed()
    if config.config['smtp']['starttls']:
        smtp.starttls()
    smtp.login(config.config['smtp']['user'], config.config['smtp']['pass'])
    smtp.send_message(msg)
    smtp.quit()
