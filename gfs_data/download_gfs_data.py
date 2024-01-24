#!/usr/bin/python3

import common
import datetime as dt
import gfs
import logging

import log_help

LG = logging.getLogger('main')
log_file = '.'.join( __file__.split('/')[-1].split('.')[:-1] ) + '.log'
lv = logging.DEBUG
logging.basicConfig(level=lv,
                format='%(asctime)s %(name)s:%(levelname)s-%(message)s',
                datefmt='%Y/%m/%d-%H:%M',
                filename = log_file, filemode='w')

log_help.screen_handler(LG, lv=lv)

fmt = '%d/%m/%Y-%H:%M'

def main(fini = 'config.ini'):
################################# LOGGING ####################################
   LG.info(f'Starting: {__file__}')
##############################################################################
   R = common.load(fini)

   LG.info(f'{R} ------ download main ------------------')
   LG.info(f'Downloading data: {R.start_date} - {R.end_date}')
   current_date = R.start_date
   step = dt.timedelta(hours=R.GFS_timedelta)  #XXX should be in config.ini
   max_tries = 5
   dates_calc = []

   while current_date <= R.end_date:
      dates_calc.append((current_date))
      current_date += step

   cont = 0
   while cont < max_tries:
      try:
         got_all_files = gfs.get_files(R,
                                       dates_calc,
                                       R.GFS_data_folder,
                                       wait4batch=R.wait4batch)
         if got_all_files: cont = 2*max_tries  # XXX dumb ways to exit...
      except:
         cont += 1

if __name__ == '__main__':
   main()
