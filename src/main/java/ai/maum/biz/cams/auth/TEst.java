package ai.maum.biz.cams.auth;

import org.springframework.security.crypto.bcrypt.BCrypt;

public class TEst {

        public static void main(String[] args) {
            String password = "1234";

            // 디비에 저장할 비밀번호 암호화
            String encrypted = BCrypt.hashpw(password, BCrypt.gensalt());

            System.out.println("encrypted : " + encrypted);

            // 로그인시 디비에 저장된 암호화된 문자열과 사용자가 입력한 비밀번호로 checkpw 검증
            System.out.println(BCrypt.checkpw(password, encrypted)); // true
            System.out.println(BCrypt.checkpw(password + "1", encrypted)); // false
        }
}
