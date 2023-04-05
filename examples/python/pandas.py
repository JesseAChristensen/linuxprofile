'''
This snippet is for quick profiling of a csv data set within pandas
pip install pandas
'''
import pandas as pd
import pandas_profiling

dataToProfile = pd.read_csv('example.csv')
# This line will display the report in a jupyter notebook
pandas_profiling.ProfileReport(dataToProfile)
# These lines will export the report to an interactive html file
profile = pandas_profiling.ProfileReport(dataToProfile)
profile.to_file(outputfile="example.html")



'''
This snippet is for interactive panda plots using ploty and cufflinks.
This is an extension of the previous snippet
pip install plotly
pip install cufflinks
'''
import cufflinks as cf
import plotly.offline
cf.go_offline()
cf.set_config_file(offline=False, world_readable=True)
dataToProfile.iplot()
