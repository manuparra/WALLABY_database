#TODO(austin): unittests to make sure users are able to use these classes to interact with the database

from sqlalchemy import Column
from sqlalchemy import Integer, String, DateTime, ForeignKey, \
                       Numeric, Boolean
from sqlalchemy.dialects.postgresql import ARRAY, JSONB, BYTEA, \
                                           DOUBLE_PRECISION
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


class Detection(Base):
    __tablename__ = 'detection'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    instance_id = Column(Integer, ForeignKey('wallaby.instance.id'))
    run_id = Column(Integer, ForeignKey('wallaby.run.id'))
    name = Column(String)
    access_url = Column(String)
    access_format = Column(String)
    x = Column(DOUBLE_PRECISION)
    y = Column(DOUBLE_PRECISION)
    z = Column(DOUBLE_PRECISION)
    x_min = Column(Numeric)
    x_max = Column(Numeric)
    y_min = Column(Numeric)
    y_max = Column(Numeric)
    z_min = Column(Numeric)
    z_max = Column(Numeric)
    n_pix = Column(Numeric)
    f_min = Column(DOUBLE_PRECISION)
    f_max = Column(DOUBLE_PRECISION)
    f_sum = Column(DOUBLE_PRECISION)
    rel = Column(DOUBLE_PRECISION)
    rms = Column(DOUBLE_PRECISION)
    w20 = Column(DOUBLE_PRECISION)
    w50 = Column(DOUBLE_PRECISION)
    ell_maj = Column(DOUBLE_PRECISION)
    ell_min = Column(DOUBLE_PRECISION)
    ell_pa = Column(DOUBLE_PRECISION)
    ell3s_maj = Column(DOUBLE_PRECISION)
    ell3s_min = Column(DOUBLE_PRECISION)
    ell3s_pa = Column(DOUBLE_PRECISION)
    kin_pa = Column(DOUBLE_PRECISION)
    ra = Column(DOUBLE_PRECISION)
    dec = Column(DOUBLE_PRECISION)
    l = Column(DOUBLE_PRECISION)  # noqa
    b = Column(DOUBLE_PRECISION)
    v_rad = Column(DOUBLE_PRECISION)
    v_opt = Column(DOUBLE_PRECISION)
    v_app = Column(DOUBLE_PRECISION)
    err_x = Column(DOUBLE_PRECISION)
    err_y = Column(DOUBLE_PRECISION)
    err_z = Column(DOUBLE_PRECISION)
    err_f_sum = Column(DOUBLE_PRECISION)
    freq = Column(DOUBLE_PRECISION)
    flag = Column(Integer)
    unresolved = Column(Boolean)
    wm50 = Column(Numeric, nullable=True)
    x_peak = Column(Integer, nullable=True)
    y_peak = Column(Integer, nullable=True)
    z_peak = Column(Integer, nullable=True)
    ra_peak = Column(Numeric, nullable=True)
    dec_peak = Column(Numeric, nullable=True)
    freq_peak = Column(Numeric, nullable=True)
    l_peak = Column(Numeric, nullable=True)
    b_peak = Column(Numeric, nullable=True)
    v_rad_peak = Column(Numeric, nullable=True)
    v_opt_peak = Column(Numeric, nullable=True)
    v_app_peak = Column(Numeric, nullable=True)


class Product(Base):
    __tablename__ = 'product'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    detection_id = Column(Integer, ForeignKey('wallaby.detection.id'))
    cube = Column(BYTEA)
    mask = Column(BYTEA)
    mom0 = Column(BYTEA)
    mom1 = Column(BYTEA)
    mom2 = Column(BYTEA)
    snr = Column(BYTEA, nullable=True)
    chan = Column(BYTEA, nullable=True)
    spec = Column(BYTEA)


class Source(Base):
    __tablename__ = 'source'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    name = Column(String)


class SourceDetection(Base):
    __tablename__ = 'source_detection'
    __table_args__ = {'schema': 'wallaby'}

    id = Column(Integer, primary_key=True)
    source_id = Column(Integer, ForeignKey('wallaby.source.id'))
    detection_id = Column(Integer, ForeignKey('wallaby.detection.id'))
