# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

from sqlalchemy.ext.declarative import declarative_base
from db.db import engine, session
from sqlalchemy import (MetaData,
                        Column,
                        Integer,
                        Text,
                        DateTime,
                        LargeBinary,)

from db.env import DB_SCHEMA

meta = MetaData(schema=DB_SCHEMA)

Base = declarative_base(metadata=meta)


class WebentityMixin:
     id = Column(Integer, primary_key=True)
     url = Column(Text)

     @classmethod
     def make(cls, item):
          return cls(url=item['url'])


class PageMixin(WebentityMixin):
     title = Column(Text)
     page_code = Column(LargeBinary)
     tags = Column(Text)
     publishing_date = Column(DateTime)
     crawling_date = Column(DateTime)

     @classmethod
     def make(cls, item):
          return cls(url=item['url'],
              title=item['title'],
              tags=item['tags'],
              page_code=item['page_code'],
              publishing_date=item['publishing_date'],
              crawling_date=item['crawling_date'])


class Scraps(PageMixin, Base):
     __tablename__ = 'scraps'


class Links(WebentityMixin, Base):
     __tablename__ = 'links'
     downloaded = Column(Integer(), default=0)


# this generates all tables for declared models
Base.metadata.create_all(engine, checkfirst=True)

def get_links(limit = 50000):
    for link in session.query(Links). \
                filter(Links.downloaded == 0).limit(50000). \
                all():

        # cleaned url
        yield link.url.replace("http://", "https://")