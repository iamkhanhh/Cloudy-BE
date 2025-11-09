'use strict';

var dbm;
var type;
var seed;

/**
  * We receive the dbmigrate dependency from dbmigrate initially.
  * This enables us to not have to rely on NODE_PATH.
  */
exports.setup = function(options, seedLink) {
  dbm = options.dbmigrate;
  type = dbm.dataType;
  seed = seedLink;
};

exports.up = function(db, callback) {
	db.createTable('shares', {
		id: {
			type: 'int',
			primaryKey: true,
			unique: true,
			autoIncrement: true,
			length: 11
		},
		resource_type: {
			type: 'string',
		},
		resource_id: {
			type: 'int',
		},
		owner_id: {
			type: 'int'
		},
		permission: {
			type: 'string',
			length: 255,
			required: true
		},
		token: {
			type: 'string',
		},
		password_hash: {
			type: 'string',
		},
		receiver_id: {
			type: 'int'
		},
		expires_at: {
			type: 'timestamp',
		},
		is_deleted: {
			type: 'int',
			length: 1,
			defaultValue: 0
		},
		createdAt: {
			type: 'timestamp',
			defaultValue: new String('CURRENT_TIMESTAMP')
		},
		updatedAt: {
			type: 'timestamp',
			defaultValue: new String('CURRENT_TIMESTAMP')
		}
	}, callback)
};

exports.down = function(db, callback) {
	return db.dropTable('shares', callback);
};

exports._meta = {
  "version": 1
};
