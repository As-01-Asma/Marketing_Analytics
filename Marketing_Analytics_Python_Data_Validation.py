import pandas as pd
from pathlib import Path

# MARKETING ANALYTICS - PYTHON DATA VALIDATION

folder = Path(__file__).resolve().parent

fact_df = pd.read_csv(
    folder / "fact_customer_reviews_with_sentiment.csv"
)

enriched_df = pd.read_csv(
    folder / "customer_reviews_enriched.csv"
)


# 1. DATASET SIZE VALIDATION
# Checked total records and columns.
# Result: 1,363 rows and 9 columns.

print("Dataset Size:", fact_df.shape)


# 2. MISSING VALUE VALIDATION
# Checked missing values in all columns.
# Result: 0 missing values.

print("Missing Values:", fact_df.isnull().sum().sum())


# 3. DUPLICATE VALIDATION
# Checked duplicate rows and duplicate ReviewIDs.
# Result: 0 duplicate rows and 0 duplicate ReviewIDs.

print("Duplicate Rows:", fact_df.duplicated().sum())
print("Duplicate ReviewIDs:", fact_df["ReviewID"].duplicated().sum())


# 4. SENTIMENT DISTRIBUTION
# Checked customer reviews across sentiment categories.
# Result: Positive 840, Negative 226, Mixed Negative 196,
# Mixed Positive 86, Neutral 15.
# Total: 1,363 reviews.

print("\nSentiment Distribution:")
print(fact_df["Sentiment"].value_counts())


# 5. SENTIMENT COUNT VALIDATION
# Checked whether sentiment records match total review records.
# Result: 1,363 sentiment records matched 1,363 reviews.

print("\nSentiment Total:", fact_df["Sentiment"].count())
print("Review Total:", len(fact_df))


# 6. CSV RECORD COUNT VALIDATION
# Compared both exported CSV files.
# Result: Both files contain 1,363 records.

print("\nFact CSV Rows:", len(fact_df))
print("Enriched CSV Rows:", len(enriched_df))


# 7. REVIEW ID VALIDATION
# Checked ReviewID consistency and record order in both CSV files.
# Result: ReviewIDs matched in the same order.

print(
    "\nReviewID Match:",
    fact_df["ReviewID"].equals(enriched_df["ReviewID"])
)