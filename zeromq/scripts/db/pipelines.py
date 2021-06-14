# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://doc.scrapy.org/en/latest/topics/item-pipeline.html

from db.db import session
from db.items import Scraps, Links
from datetime import datetime
#from logging import logging

class WykopplPipeline(object):

    choices = {

    }

    def process_item(self, item, spider):
        function_name = self.choices.get(type(item), 'empty')

        getattr(self, function_name)(item)

        return item

    def empty(self, item):
        print("dupa dupa dupa dupa dupa dupa blada.") #logging.error('Something is empty in pipeline')
        pass

    def process_link(self, link_item):
        link = Links.make(link_item)

        url = link.url
        link_in_db = session.query(Links).filter_by(url=url).first()

        if not link_in_db:
            session.add(link)
            session.commit()

        pass

    def process_page(self, downloaded_item):
        # now = datetime.now()
        # downloaded_item['crawling_date'] = now
        NOT_DOWNLOADED = 0
        DOWNLOADED = 1
        page = Scraps.make(downloaded_item)

        url = page.url
        link = session.query(Links).filter_by(url=url).first()
        not_downloaded = lambda link: link.downloaded == NOT_DOWNLOADED

        if not_downloaded(link):
            link.downloaded = DOWNLOADED
            session.add(link)
            session.add(page)
            session.commit()

        pass
