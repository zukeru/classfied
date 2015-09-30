#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Copyright [current year] the Melange authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


from subprocess import Popen, PIPE
from multiprocessing import Pool, Process
from datetime import datetime
import sys
import os
import argparse
import logging
import logging.config
from bottle import route, run, Bottle, template,request,static_file,get
import json
import re
from collections import defaultdict
import hashlib
import time
import sqlite3 as lite
import random
import time
import socket
from ConfigParser import SafeConfigParser
global database_name



@route('/api/users', method='GET')
def load_data( name="Execute Load" ):
    return "users"

def shell_command_execute(command):
    p = Popen(command, stdout=PIPE, shell=True)
    (output, err) = p.communicate()
    return output

def connect_db():
    con = None
    con = lite.connect(database_name)
    cur = con.cursor() 
    objects = []
    #objects.append(con,cur)
    objects.append(con)
    objects.append(cur)
    return objects

def build_db_tables(logger):
    
    init_db = connect_db()
    con = init_db[0]
    cur = init_db[1]    
    
    try:
        logger.info('Building User Tables.') 
        cur.execute("""CREATE TABLE users(ID INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)""")
    except Exception as e:
        logger.info(str(e))
        pass
    try:
        logger.info('Building Chat Tables.') 
        cur.execute("""CREATE TABLE chats(ID INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, message TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)""")
    except Exception as e:
        logger.info(str(e))
        pass    
    con.commit()
    con.close()    

 
if __name__ == '__main__':
    #init logging
    try:
        logging.basicConfig(filename='master.log', filemode='a', level=logging.INFO)
        logger = logging.getLogger('queue_manager')    

        parser = SafeConfigParser()
        config_url = os.path.dirname(os.path.realpath(__file__)) + '\config.ini'
        parser.read(config_url)
        database_name = parser.get('master', 'database')
    except Exception as e:
        print e
        logging.error(str(e))
        sys.exit(2)
    
    #build database tables, if they exist do nothing        
    build_db_tables(logger)   
    #this builds the database of host, uses ec2 discovery.

    try:    
        ip_address = socket.gethostbyname(socket.gethostname())
        logger.info('Starting API SERVER.')
        run(host='127.0.0.1', port=8001, debug=True)
    except Exception as e:
        logger.error(str(e))
