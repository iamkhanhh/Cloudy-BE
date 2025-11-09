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
	db.createTable('albums', {
		id: {
			type: 'int',
			primaryKey: true,
			unique: true,
			autoIncrement: true,
			length: 11
		},
		owner_id: {
			type: 'int'
		},
		name: {
			type: 'string'
		},
		description: {
			type: 'string'
		},
		cover_media_id: {
			type: 'int',
		},
		visibility: {
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
	return db.dropTable('albums', callback);
};

exports._meta = {
  "version": 1
};
