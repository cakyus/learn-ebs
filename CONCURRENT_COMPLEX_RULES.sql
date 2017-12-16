-- DESCRIPTION: Form Combined Specialization Rules
-- TODO: TYPE_CODE: Program, Oracle ID

SELECT R.COMPLEX_RULE_NAME
	, DECODE(L.INCLUDE_FLAG, 'I', 'Include', 'E', 'Exclude', NULL) INCLUDE_FLAG_T
	, DECODE(L.TYPE_CODE, 'U', 'User', NULL) TYPE_CODE_T
	, AL.APPLICATION_NAME
	, DECODE(L.TYPE_CODE, 'U', U.USER_NAME, NULL) TYPE_ID_T
FROM FND_CONCURRENT_COMPLEX_LINES L
	LEFT JOIN FND_CONCURRENT_COMPLEX_RULES R
		ON R.APPLICATION_ID = L.APPLICATION_ID
			AND R.COMPLEX_RULE_ID = L.COMPLEX_RULE_ID 
	LEFT JOIN (
		SELECT A.APPLICATION_ID, L.APPLICATION_NAME
		FROM FND_APPLICATION A
		INNER JOIN FND_APPLICATION_TL L ON A.APPLICATION_ID = L.APPLICATION_ID
		WHERE L.LANGUAGE = 'US'
	) AL ON AL.APPLICATION_ID = L.TYPE_APPLICATION_ID
	LEFT JOIN FND_USER U
		ON L.TYPE_ID = U.USER_ID AND L.TYPE_CODE = 'U'
