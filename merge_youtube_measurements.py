import pandas as pd
import sqlite3

tables = ['lookups', 'qlogs', 'page_resources', 'nerd_stats', 'iframe_api', 'measurements']
dbs = ['web-performance-youtube-afsouth.db', 'web-performance-youtube-apnorth.db', 'web-performance-youtube-apsouth.db', 'web-performance-youtube-eucentral.db', 'web-performance-youtube-saeast.db', 'web-performance-youtube-useast.db', 'web-performance-youtube-uswest.db']
for db in dbs:
	conn = sqlite3.connect(db)
	for table in tables:
		df_tmp = pd.read_sql_query("SELECT * from "+table, conn)
		df_tmp.to_sql(name=table, con=conn, if_exists='append', index=False)