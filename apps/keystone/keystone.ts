// Welcome to Keystone!
//
// This file is what Keystone uses as the entry-point to your headless backend
//
// Keystone imports the default export of this file, expecting a Keystone configuration object
//   you can find out more at https://keystonejs.com/docs/apis/config

import { config } from '@keystone-6/core'

// to keep this file tidy, we define our schema in a different file
import { lists } from './schema'

// authentication is configured separately here too, but you might move this elsewhere
// when you write your list-level access control functions, as they typically rely on session data
import { withAuth, session } from './auth'

export default withAuth(
  config({
    db: {
      // we're using sqlite for the fastest startup experience
      //   for more information on what database might be appropriate for you
      //   see https://keystonejs.com/docs/guides/choosing-a-database#title
       //provider: 'postgresql',
      // url: 'postgresql://pguser:secret_secret_secret@keystone_postgres_db:5432'


      url: 'file:./db/keystone.db',
      provider: 'sqlite',
      //url: 'file:./keystone.db',
    },
    lists,
    session,  
    server: {
      port: 8080
    },
    /*
    storage: {
      my_local_images: {
        kind: 'local',
        type: 'image',
        preserve: false,
        serverRoute: {
          path: '/images'
        },
        generateUrl: path => `http://localhost:8080/images${path}`,
        storagePath: '/public/keystone/images'
      },
      my_local_files: {
        kind: 'local',
        type: 'file',
        preserve: false,
        serverRoute: {
          path: '/files'
        },
        generateUrl: path => `http://localhost:8080/files${path}`,
        storagePath: '/public/keystone/files'
      },
    }
      */
  })
)
