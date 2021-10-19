from sqlalchemy import Column
from sqlalchemy import Integer, String, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import ARRAY, JSONB, BYTEA
from sqlalchemy.orm import declarative_base
from sqlalchemy.ext.mutable import MutableDict


Base = declarative_base()


class Run(Base):
    __tablename__ = 'run'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    name = Column(String)
    sanity_thresholds = Column(MutableDict.as_mutable(JSONB))


class Instance(Base):
    __tablename__ = 'instance'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    run_id = Column(Integer, ForeignKey('wallaby.run.id'))
    filename = Column(String)
    boundary = Column(ARRAY(Integer))
    run_date = Column(DateTime)
    flag_log = Column(BYTEA)
    reliability_plot = Column(BYTEA)
    log = Column(BYTEA)
    parameters = Column(MutableDict.as_mutable(JSONB))
    version = Column(String)
    return_code = Column(Integer)
    stdout = Column(BYTEA)
    stderr = Column(BYTEA)
