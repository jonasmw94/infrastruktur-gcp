exports.testPubSub = (message, context) => {
    async function insertRowsAsStream() {
        const { BigQuery } = require("@google-cloud/bigquery");
        const bigquery = new BigQuery();

        const rows = [
            {transaction_id: 'filenameid', transaction_name: "filename"}
        ];

        await bigquery
            .dataset('infrastructu_tut_bew_wo_2022_dataset')
            .table('transaction')
            .insert(rows);
            console.log(`Inserted ${rows.length} rows`);
    }

    insertRowsAsStream();
};
