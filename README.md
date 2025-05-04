# Alpha Lending Protocol

Alpha Lending is a decentralized lending protocol built on Sui that enables users to lend, borrow, and manage collateralized positions. This repository contains the smart contracts that power the protocol.

## Features

- Create and manage lending positions
- Add and remove collateral
- Borrow and repay assets
- Liquidate undercollateralized positions
- Collect rewards from positions
- Manage LP positions
- Handle protocol fees and rewards
- Price oracle for accurate asset valuation

## Contract Usage

### Creating a Position

To create a new position:

```move
let position_cap = alpha_lending::create_position(
    &mut protocol,
    ctx
);
```

### Managing Collateral

#### Adding Collateral

```move
let remaining_coin = alpha_lending::add_collateral<C>(
    &mut protocol,
    &position_cap,
    market_id,
    coin,
    &clock,
    ctx
);
```
A position capability needs to be created, if the user does not already have one, before collateral can be added.

#### Removing Collateral

```move
let liquidity_promise = alpha_lending::remove_collateral<C>(
    &mut protocol,
    &position_cap,
    market_id,
    amount,
    &clock,
    ctx
);
```
Note: This returns a LiquidityPromise that needs to be fulfilled to receive the collateral back.

### Borrowing and Repaying

#### Borrowing Assets

```move
let liquidity_promise = alpha_lending::borrow<C>(
    &mut protocol,
    &position_cap,
    market_id,
    amount,
    &clock,
    ctx
);
```
Note: This returns a LiquidityPromise that needs to be fulfilled to receive the borrowed coin.

#### Repaying Borrowed Assets

```move
let remaining_coin = alpha_lending::repay<C>(
    &mut protocol,
    &position_cap,
    market_id,
    coin,
    &clock,
    ctx
);
```

### Liquidation

To liquidate an undercollateralized position:

```move
let (liquidity_promise, remaining_repay_coin) = alpha_lending::liquidate<B,D>(
    &mut protocol,
    liquidate_position_id,
    borrow_market_id,
    withdraw_market_id,
    repay_coin,
    &clock,
    ctx
);
```
Note: This returns a LiquidityPromise for the collateral that needs to be fulfilled.

### Managing Rewards

#### Checking Claimable Rewards

```move
let claimable_rewards = alpha_lending::get_claimable_rewards(
    &mut protocol,
    &position_cap,
    &clock
);
```

#### Collecting Rewards

```move
let (reward_coin, liquidity_promise) = alpha_lending::collect_reward<C>(
    &mut protocol,
    market_id,
    &position_cap,
    &clock,
    ctx
);
```
Note: This returns both the reward coin and a LiquidityPromise.

#### Collecting and Depositing Rewards

```move
let (remaining_reward_coin, liquidity_promise) = alpha_lending::collect_reward_and_deposit<C>(
    &mut protocol,
    market_id,
    &position_cap,
    &clock,
    ctx
);
```
Note: This returns both any remaining reward coin and a LiquidityPromise.

### Loan Bailout

To perform a loan bailout:

```move
let remaining_bailout_coin = alpha_lending::loan_bailout<C>(
    &mut protocol,
    market_id,
    position_id,
    coin,
    &clock,
    ctx
);
```

### Fulfilling Liquidity Promises

#### For Non-SUI Assets

```move
let fulfilled_coin = alpha_lending::fulfill_promise<C>(
    &mut protocol,
    market_id,
    &position_cap,
    promise,
    &clock,
    ctx
);
```

#### For SUI

```move
let fulfilled_sui = alpha_lending::fulfill_promise_SUI(
    &mut protocol,
    market_id,
    &position_cap,
    promise,
    &clock,
    ctx
);
```

## Price updation
remove_collateral, borrow and liquidate functions require the latest prices to be updated into contracts. This can be achieved by calling SDK functions to update all the prices that the position is invested in. Not updating the price results in trasaction been aborted due to assert. 

Use the below Pyth mapping for updating the price in alphafi_oracle
```typescript
export const pythPriceFeedIdMap: { [key: string]: HexString } = {
  // Mainnet price feed IDs
  "0x2::sui::SUI":
    "23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744",

  "0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI":
    "0b3eae8cb6e221e7388a435290e0f2211172563f94769077b7f4c4c6a11eea76",

  "0xaafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC":
    "e62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43",

  "0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc::LBTC":
    "e62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43",

  "0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT":
    "2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b",

  "0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC":
    "eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a",

  "0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL":
    "eba0732395fae9dec4bae12e52760b35fc1c5671e2da8b449c9af4efe5d54341",

  "0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP":
    "29bdd5248234e33bd93d3b81100b5fa32eaa5997843847e2c2cb16d7c6d9f7ff",

  "0xe1b45a0e641b9955a20aa0ad1c1f4ad86aad8afb07296d4085e349a50e90bdca::blue::BLUE":
    "04cfeb7b143eb9c48e9b074125c1a3447b85f59c31164dc20c1beaa6f21f2b6b",

  "0xd0e89b2af5e4910726fbcd8b8dd37bb79b29e5f83f7491bca830e94f7f226d29::eth::ETH":
    "ff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace",
};
```

Not all price feed need to be update. You can use the below priceInfoObject directly if they are updated with the latest price

```typescript
export const priceInfoObjectIdMap: { [key: string]: HexString } = {
  // Mainnet price feed IDs
  "0x2::sui::SUI":
    "0x801dbc2f0053d34734814b2d6df491ce7807a725fe9a01ad74a07e9c51396c37",

  "0xd1b72982e40348d069bb1ff701e634c117bb5f741f44dff91e472d3b01461e55::stsui::STSUI":
    "0x1366f68b08a61380189dbb5cfca51c541309e7856bc2bbe5adbcdc966bab8734",

  "0xaafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC":
    "0x9a62b4863bdeaabdc9500fce769cf7e72d5585eeb28a6d26e4cafadc13f76ab2",

  "0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc::LBTC":
    "0x9a62b4863bdeaabdc9500fce769cf7e72d5585eeb28a6d26e4cafadc13f76ab2",

  "0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT":
    "0x985e3db9f93f76ee8bace7c3dd5cc676a096accd5d9e09e9ae0fb6e492b14572",

  "0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC":
    "0x5dec622733a204ca27f5a90d8c2fad453cc6665186fd5dff13a83d0b6c9027ab",

  "0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL":
    "0xeb7e669f74d976c0b99b6ef9801e3a77716a95f1a15754e0f1399ce3fb60973d",

  "0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP":
    "0x8c7f3a322b94cc69db2a2ac575cbd94bf5766113324c3a3eceac91e3e88a51ed",

  "0xe1b45a0e641b9955a20aa0ad1c1f4ad86aad8afb07296d4085e349a50e90bdca::blue::BLUE":
    "0x5515a34fc610bba6b601575ed1d2535b2f9df1f339fd0d435fef487c1ee3df9c",

  "0xd0e89b2af5e4910726fbcd8b8dd37bb79b29e5f83f7491bca830e94f7f226d29::eth::ETH":
    "0x9193fd47f9a0ab99b6e365a464c8a9ae30e6150fc37ed2a89c1586631f6fc4ab",
};
```

AlphaLend constants as of 4th May 2025 are
```typescript
ALPHAFI_LATEST_ORACLE_PACKAGE_ID:
    "0x39850d8deb783ef11b10487dc8a80a701506b1471ce11cde83124f35ba3da699",

  ALPHAFI_ORACLE_OBJECT_ID:
    "0xce4ca140eb264bdc5b03f3268eeb013495f04561e38473aadcf654fb0db6b096",

  ALPHAFI_FIRST_STDLIB_PACKAGE_ID:
    "0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc",

  ALPHAFI_LATEST_STDLIB_PACKAGE_ID:
    "0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc",

ALPHALEND_FIRST_PACKAGE_ID:
    "0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4",

  ALPHALEND_LATEST_PACKAGE_ID:
    "0xee754fc0c6d977403c9218cedbfffed033b4b42b50a65c2c3f1c7be13efeafd2",

  LENDING_PROTOCOL_ID:
    "0x01d9cf05d65fa3a9bb7163095139120e3c4e414dfbab153a49779a7d14010b93",
```

Price can be updated using the below sample functions
```typescript
function updatePriceTransaction(
  tx: Transaction,
  args: UpdatePriceTransactionArgs,
  constants: Constants,
) {
  tx.moveCall({
    target: `${ALPHAFI_LATEST_ORACLE_PACKAGE_ID}::oracle::update_price_from_pyth`,
    arguments: [
      tx.object(ALPHAFI_ORACLE_OBJECT_ID),
      tx.object(args.priceInfoObject),
      tx.object(SUI_CLOCK_OBJECT_ID),
    ],
  });

  const coinTypeName = tx.moveCall({
    target: `0x1::type_name::get`,
    typeArguments: [args.coinType],
  });

  const oraclePriceInfo = tx.moveCall({
    target: `${ALPHAFI_LATEST_ORACLE_PACKAGE_ID}::oracle::get_price_info`,
    arguments: [tx.object(ALPHAFI_ORACLE_OBJECT_ID), coinTypeName],
  });

  tx.moveCall({
    target: `${ALPHALEND_LATEST_PACKAGE_ID}::alpha_lending::update_price`,
    arguments: [tx.object(LENDING_PROTOCOL_ID), oraclePriceInfo],
  });
}
```


