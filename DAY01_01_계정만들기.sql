-- 한 줄 주석
/*
    여러 줄 주석
    여러 줄 주석
*/

/*
    SQL DEVELOPER 쿼리문 실행
    1. 커서 + CTRL + ENTER : 커서가 있는 쿼리문 실행
    2. 블록 + CTRL + ENTER : 블록 안 쿼리문 실행
    3. F5                  : 전체 스크립트 실행

    관리자 계정
    1. 이름 : SYS, SYSTEM
    2. 새 계정 생성
    3. 관리자 계정으로 작업X

    계정 생성
    CREATE USER [계정명] IDENTIFIED BY [비밀번호];
    
    권한 부여
    GRANT [권한] TO [계정명];
    
    계정 삭제
    1. 데이터가 없을 경우 : DROP USER [계정명];
    2.          있을 경우 : DROP USER [계정명] CASCADE;

CREATE USER C##GD IDENTIFIED BY 1111; -- 계정 생성
GRANT CONNECT TO C##GD; -- 접속 권한 부여
DROP USER C##GD; -- 계정 삭제

*/

-- 새로운 계정 생성 스크립트
ALTER SESSION SET "_ORACLE_SCRIPT"= TRUE; -- 계정명 앞 C## 생략
DROP USER GD CASCADE;                     -- 기존 계정 GD와 데이터 삭제
CREATE USER GD IDENTIFIED BY 1111;        -- 새 계정 GD 생성
GRANT DBA TO GD;                          -- 새 계정 GD에 DBA 권한 부여

