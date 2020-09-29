const NearProver = artifacts.require("NearProver");

const bridge = "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"; // fake
const proof = "0x01000000ea815c8c074d2422cc0254f0b1d91efd2032100aa95c1530929124dc42c93185009613df5ede94b9a01e4d79a9e8ac29b81c98bba6d5e9e393a384d1eff5df83380831ba5c6040b378ec88c87f8c4ac9d1672ed7eb3101788a1a55dbe1053774ec00000000010000001592a13f0648c6e19cbdfe76c07e7008af15d9558423e25874e5ee918e6a9a7ff8654cefee03000000f8f6936d82cc7117000000000000000b0000006c65652e746573746e6574022000000000000000000000000000000000000000000000000000000000000000000004d2000000002b048995863352032a161ce79ba1d64e7dfe9f37645d110883b7545afa161298f9cf487bcbb15a98e71285cde808f486df0d6d3919d165cc1fb53cbe3af7385c35f60b01000000000b534a9288d2bd85d25eb2338b642fff6ce3c2fb97069d97e5efd313e2c154b194a681b3042e5059d6d359666f62161217b9f405ce8888e1799374bd71796b52afad1dfc37e0b0d8e81e6bcbc7a0e9a442e94d0b4c1566687afc909c63873dbd04f93df680f3738ed80b086b81c96df79d2be5f136cabd883a9b3a5a0e3036ecd0b4f1ad03513816760109338dbc71322c2e9418c4f98535a1c1592949d4fef05b3d2bf580b018efc11a9c348c595fd4d54cf2a8afa333ad909ef73824b3ecdfb463ee162cbf239a0a0000002b048995863352032a161ce79ba1d64e7dfe9f37645d110883b7545afa16129800dd06b9d92901cbb907feba552b4754fbfcd53e3c1357e75d82ffc5cd8dfd6ae900839ae560d49de67132fd349987d3c721b90f3432f2ee24a7c9a9d632969a426500b9829a0c0214aa0f42877506eb591f388d383a7576342867fb29741d98936c5100aa4e4ef0bebd4b9640049135def2df3741b5d0e010709912f0c34639f75baaca004a7d584ad28be21f65327087f4b634d9855ffea35b38864ce54afc0efe01f1c8003f4cd8fdbdf935a56fb7e3d86f95f8c0ace91796f4514ebba1e40f63ae98aa64003629fff63493b86d47bba7d2b4ec78b6ef4bf9105cccfb6e0f9ce2092e547e4300c077707af9e1001b5b513fbf47239ab63241414710eefbc6332d1862baa5b9a1007ab23372fba14c21464c09a49b6334ab8d9491b6b64d59cfa2cd818a9f14b00d00";

const D = console.log;
async function main() {
    const c = await NearProver.new(bridge);
    const r = await c.proveOutcome(proof, 1);
    D("proof:", r);
}

module.exports = function (result) {
    return main()
        .then(result).catch(result);
}
