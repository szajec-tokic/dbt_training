import holidays

def is_holiday(date_col):
    us_holidays = holidays.USA()
    is_holiday = (date_col in us_holidays)
    return is_holiday

def model(dbt, session):

    dbt.config(
        materialized="table",
        packages = ["holidays"]
    )

    orders_df = dbt.ref("orders")

    df = orders_df.to_pandas()

    df["IS_HOLIDAY"] = df["CREATED_AT_DT"].apply(is_holiday)

    df_final = df[df["IS_HOLIDAY"] == True]

    return df_final