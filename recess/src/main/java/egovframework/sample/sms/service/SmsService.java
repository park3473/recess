package egovframework.sample.sms.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import egovframework.sample.sms.model.SmsVo;

public interface SmsService {

	void SmsSend(SmsVo smsVo) throws IOException , NoSuchAlgorithmException;

}
