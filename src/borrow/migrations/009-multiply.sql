CREATE SCHEMA multiply;

CREATE TABLE multiply.method_called (
    id                  serial primary key,
    method_name         character varying(32) not null,
    cdp_id              character varying(66) not null,
    urn                 character varying(66) not null,
    
    swap_min_amount       decimal(78,0) not null,
    swap_optimist_amount  decimal(78,0) not null,
    collateral_left      decimal(78,0) not null,
    dai_left             decimal(78,0) not null,

    log_index  integer not null,
    tx_id      integer not null REFERENCES vulcan2x.transaction(id) ON DELETE CASCADE,
    block_id   integer not null REFERENCES vulcan2x.block(id) ON DELETE CASCADE,
    unique (tx_id, log_index)
);

CREATE TABLE multiply.flashloan (
    id         serial primary key,
    borrowed   decimal(78,0) not null,
    due        decimal(78,0) not null,

    log_index  integer not null,
    tx_id      integer not null REFERENCES vulcan2x.transaction(id) ON DELETE CASCADE,
    block_id   integer not null REFERENCES vulcan2x.block(id) ON DELETE CASCADE,
    unique (tx_id, log_index)
);

CREATE INDEX multiply_method_called ON multiply.method_called(tx_id);
CREATE INDEX multiply_flashloan ON multiply.flashloan(tx_id);

CREATE SCHEMA exchange;