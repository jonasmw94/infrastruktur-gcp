exports.testPubSub = (message, context) => {
    async function insertRowsAsStream() {
        const { BigQuery } = require("@google-cloud/bigquery");
        const jwt_decode = require('jwt-decode');
        const bigquery = new BigQuery();

        const decoded = jwt_decode(message.data, { header: true });

        const rows = [
            {transaction_id: decoded.md5Hash, transaction_name: decoded.name}
        ];
        
        if (decoded.name.toLowerCase().includes(".pdf")) {
            await bigquery
            .dataset('infrastructu_tut_bew_wo_2022_dataset')
            .table('transaction')
            .insert(rows);
            console.log(`Inserted ${rows.length} row(s)`);
        }else {
            console.log("Ignoring file " + decoded.name)
        }
    }

    insertRowsAsStream();
};
