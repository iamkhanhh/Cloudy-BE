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
	db.createTable('album_media', {
		id: {
			type: 'int',
			primaryKey: true,
			unique: true,
			autoIncrement: true,
			length: 11
		},
		album_id: {
			type: 'int'
		},
		media_id: {
			type: 'int'
		},
		added_by: {
			type: 'int'
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
	return db.dropTable('album_media', callback);
};

exports._meta = {
  "version": 1
};
