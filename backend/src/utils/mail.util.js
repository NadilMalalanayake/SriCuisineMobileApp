const nodemailer = require("nodemailer");
const logger = require("../utils/log4jsutil");

exports.sendMail = async function (mailOptions) {
  logger.trace("[mailUtil] :: sendMail(): Start");
  try {
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: process.env.EMAIL_AUTH_USER,
        pass: process.env.EMAIL_AUTH_USER_PASSWORD,
      },
    });
    let message = {
      from: process.env.EMAIL_FROM,
      to: mailOptions.to,
      subject: mailOptions.subject,
      html: mailOptions.html,
      attachments: mailOptions.attachments,
    };
    const mailSent = await transporter.sendMail(message);
    logger.trace("[mailUtil] :: sendMail(): End");
    return true;
  } catch (error) {
    logger.error("[mailUtil] :: sendMail() : error : " + error);
    return false;
  }
};
