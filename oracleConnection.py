import cx_Oracle

con = cx_Oracle.connect('SYSTEM/oracle@localhost/XE')
print (con.version)

con.close()
