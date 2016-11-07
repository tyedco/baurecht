#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Alois Keel'
SITENAME = u'Baurecht Keel'
SITEURL = 'baurecht-keel.ch'
#SITELOGO = 'images/olu-logo.png'
SITEMAP = {'format' : 'xml'}

PATH = 'content'

TIMEZONE = 'Europe/Zurich'

DEFAULT_LANG = u'de'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
GOOGLE_ANALYTICS = 'UA-66947311-1'
#DISQUS_SITENAME = 'olunz'

USE_FOLDER_AS_CATEGORY = True
DISPLAY_CATEGORIES_ON_MENU = True

MENUITEMS = [
    ('Angebot', [
        ('Dienstleistungen', "/pages/angebot.html"),
        ( 'Honorar', '/pages/honorar.html'),
        ]),
    ('Über uns', [
        ('Leitbild', '/pages/leitbild.html'),
        ('Alois Keel', '/team.html'),
        #('Publikationen', '/pages/publikationen.html'),
        ]),
    ('Aktuelles', [
        ('Stichworte', '/tags.html'),
        ('Kategorien', '/categories.html'),
        ('Chronologisch', '/archives.html'),
        ]),
    ('Kontakt', '/pages/kontakt.html'),
]

#THEME = '/home/ik/olu/themes/notallmyidea'
#THEME = '/home/ik/olu/themes/pbstr_1'
THEME = 'themes/pelican-chameleon-olu'
#BS3_THEME = 'http://bootswatch.com/flatly/bootstrap.min.css'

#THEME = '/home/ik/olu/themes/basic'
# bootstrap themes: amelia cerulean cosmo cupid custom cyborg darkly flatly journal lumen paper readable readable-old sandstone shamrock simplex slate spacelab superhero united yeti 
#BOOTSTRAP_THEME = 'simplex'
#PYGMENTS_STYLE = 'vim'
#BOOTSTRAP_FLUID = True

#STATIC_PATHS = ['images', 'downloads', 'Über uns']
STATIC_PATHS = ['images', 'downloads']
#PAGE_PATHS = ['pages', 'Über uns']
PLUGIN_PATHS = ['/home/i/olu/pelican-plugins']
PLUGINS = [
            'minification',
            'sitemap', 
            #'gallery',
            #'thumbnailer',
            #'gravatar',
            'tag_cloud'
            ]

IMAGE_PATH = 'images'
THUMBNAIL_DIR = 'thumbs'
THUMBNAIL_KEEP_NAME = True
THUMBNAIL_SIZES = {'hconst': '?x150'}
THUMBNAIL_KEEP_TREE = True

# Blogroll
#LINKS = (
         #('Pelican', 'http://getpelican.com/'),
         #('Python.org', 'http://python.org/'),
         #('Jinja2', 'http://jinja.pocoo.org/'),
#         ('You can modify those links in your config file', '#'),)

# Social widget
#SOCIAL = (('You can add links in your config file', '#'),
#          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True
