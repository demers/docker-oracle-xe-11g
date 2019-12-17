# Code venant de https://www.oracle.com/technical-resources/articles/database/python-with-database-11g.html

import cx_Oracle

con = cx_Oracle.connect('SYSTEM/oracle@localhost/XE')
print (con.version)

con.close()
