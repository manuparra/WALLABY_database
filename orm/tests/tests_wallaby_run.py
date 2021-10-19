from unittest import TestCase
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from source_finding import Run


class TestRun(TestCase):
    def setUp(self):
        """Connect to database instance.
        Requires PostgreSQL database to be running locally.
        Enter Run into table.

        """
        engine = create_engine(
            'postgresql://admin:admin@localhost:5432/wallabydb'
        )
        Session = sessionmaker(bind=engine)
        self.session = Session()

        # Add Run
        run = Run(
            name='test',
            sanity_thresholds={'x': 'y'}
        )
        self.session.add(run)
        self.session.commit()

    def tearDown(self):
        """Remove row from run table that has been inserted as part
        of this test.
        Assert no entries left in Run table.

        """
        self.session.query(Run).filter(Run.name == 'test').delete()
        self.session.commit()

        run = self.session.query(Run).filter(Run.name == 'test').all()
        self.assertEqual(run, [])

    def test_select_all(self):
        """Select all rows of the Run table from the database.

        """
        runs_count = self.session.query(Run).count()
        self.assertTrue(runs_count >= 1)

    def test_select_row(self):
        """Select row from Run table with name matching.

        """
        run_count = self.session.query(Run).filter(Run.name == 'test').count()
        self.assertTrue(run_count == 1)

    def test_update_row(self):
        """Update the entry in the Run table. Assert change has been committed.

        """
        run = self.session.query(Run).filter(Run.name == 'test').first()
        run.sanity_thresholds = {'y': 'z'}
        self.session.commit()

        # Assert updated
        run = self.session.query(Run).filter(Run.name == 'test').first()
        self.assertEqual(run.sanity_thresholds, {'y': 'z'})
