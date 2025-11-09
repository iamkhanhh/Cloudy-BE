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
	db.createTable('media', {
		id: {
			type: 'int',
			primaryKey: true,
			unique: true,
			autoIncrement: true,
			length: 11
		},
		owner_id: {
			type: 'int',
			length: 100
		},
		type: {
			type: 'string',
		},
		mime_type: {
			type: 'string'
		},
		filename: {
			type: 'string',
		},
		size: {
			type: 'int',
		},
		duration_ms: {
			type: 'int',
		},
		visibility: {
			type: 'string'
		},
		processing_status: {
			type: 'string',
		},
		file_path: {
			type: 'string'
		},
		caption: {
			type: 'string',
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
	return db.dropTable('media', callback);
};

exports._meta = {
  "version": 1
};
