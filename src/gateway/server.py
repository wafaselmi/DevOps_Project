import os, gridfs, pika, json
from flask import Flask, request
from flask_pymongo import PyMongo
from auth import validate
from auth_sSVC import access
from storage import util

server = Flask(__name__)
server.config["MONGO_URI"]= "mongodb://host.minikube.internal:27/videos"
mongo = PyMongo(server) 

fs = gridfs.GridFS(mongo.db)